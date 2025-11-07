import 'dart:async';
import 'package:flutter/material.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/risk_sorting_service.dart';


class IngredientsScreenModel extends FlutterFlowModel {
  final unfocusNode = FocusNode();
  FocusNode? searchFocusNode;
  TextEditingController? searchController;
  String? Function(BuildContext, String?)? searchControllerValidator;
  ScrollController? listViewController;
  List<IngredientsRow> ingredientsList = [];
  bool isLoading = true;
  String searchQuery = '';
  
  static const int batchSize = 10;
  int currentOffset = 0;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  
  Timer? _searchDebounce;

  void initState(BuildContext context) {
    listViewController = ScrollController();
    listViewController?.addListener(_onScroll);
    updateOnChange = true;
    loadIngredients();
  }

  void dispose() {
    unfocusNode.dispose();
    searchFocusNode?.dispose();
    searchController?.dispose();
    listViewController?.removeListener(_onScroll);
    listViewController?.dispose();
    _searchDebounce?.cancel();
  }

  void _onScroll() {
    if (listViewController?.position.pixels == listViewController?.position.maxScrollExtent) {
      if (hasMoreData && !isLoadingMore && searchQuery.isEmpty) {
        loadMoreIngredients();
      }
    }
  }

  Future<void> loadIngredients() async {
    debugPrint('[Ingredients] loadIngredients → start');
    isLoading = true;
    currentOffset = 0;
    hasMoreData = true;
    ingredientsList.clear();
    onUpdate();

    try {
      final ingredients = await IngredientsTable().queryRows(
        queryFn: (q) => q
          .order('name')
          .range(currentOffset, currentOffset + batchSize - 1),
      );
      
      debugPrint('[Ingredients] loadIngredients → fetched ${ingredients.length} rows');
      ingredientsList = RiskSortingService.sortIngredientsByRisk(ingredients);
      hasMoreData = ingredients.length == batchSize;
      currentOffset += batchSize;
      isLoading = false;
      onUpdate();
    } catch (e) {
      debugPrint('[Ingredients] loadIngredients → error: $e');
      isLoading = false;
      onUpdate();
    }
  }

  Future<void> loadMoreIngredients() async {
    if (isLoadingMore || !hasMoreData) return;
    
    isLoadingMore = true;
    onUpdate();

    try {
      final ingredients = await IngredientsTable().queryRows(
        queryFn: (q) => q
          .order('name')
          .range(currentOffset, currentOffset + batchSize - 1),
      );
      
      debugPrint('[Ingredients] loadMoreIngredients → fetched ${ingredients.length} rows (offset $currentOffset)');
      final sortedIngredients = RiskSortingService.sortIngredientsByRisk(ingredients);
      ingredientsList.addAll(sortedIngredients);
      hasMoreData = ingredients.length == batchSize;
      currentOffset += batchSize;
      isLoadingMore = false;
      onUpdate();
    } catch (e) {
      debugPrint('[Ingredients] loadMoreIngredients → error: $e');
      isLoadingMore = false;
      onUpdate();
    }
  }

  void updateSearchQuery(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      searchIngredients(query);
    });
  }

  void onSearchChanged(String query) {
    updateSearchQuery(query);
  }

  Future<void> searchIngredients(String query) async {
    if (query.isEmpty) {
      searchQuery = '';
      currentOffset = 0;
      hasMoreData = true;
      await loadIngredients();
      return;
    }

    debugPrint('[Ingredients] searchIngredients("$query") → start');
    searchQuery = query;
    isLoading = true;
    onUpdate();

    try {
      final searchResults = await IngredientsTable().queryRows(
        queryFn: (q) => q
          .or('name.ilike.%$query%,ro_name.ilike.%$query%')
          .order('name')
          .limit(50),
      );
      
      debugPrint('[Ingredients] searchIngredients("$query") → ${searchResults.length} rows');
      ingredientsList = RiskSortingService.sortIngredientsByRisk(searchResults);
      hasMoreData = false; // No pagination for search results
      isLoading = false;
      onUpdate();
    } catch (e) {
      debugPrint('[Ingredients] searchIngredients("$query") → error: $e');
      isLoading = false;
      onUpdate();
    }
  }

  List<IngredientsRow> getFilteredIngredients() {
    return ingredientsList;
  }
}
