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
      
      ingredientsList = RiskSortingService.sortIngredientsByRisk(ingredients);
      hasMoreData = ingredients.length == batchSize;
      currentOffset += batchSize;
      isLoading = false;
      onUpdate();
    } catch (e) {
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
      
      final sortedIngredients = RiskSortingService.sortIngredientsByRisk(ingredients);
      ingredientsList.addAll(sortedIngredients);
      hasMoreData = ingredients.length == batchSize;
      currentOffset += batchSize;
      isLoadingMore = false;
      onUpdate();
    } catch (e) {
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

    searchQuery = query;
    isLoading = true;
    onUpdate();

    try {
      final searchResults = await IngredientsTable().queryRows(
        queryFn: (q) => q
          .or('name.ilike.%$query%,name_ro.ilike.%$query%')
          .order('name')
          .limit(50),
      );
      
      ingredientsList = RiskSortingService.sortIngredientsByRisk(searchResults);
      hasMoreData = false; // No pagination for search results
      isLoading = false;
      onUpdate();
    } catch (e) {
      isLoading = false;
      onUpdate();
    }
  }

  List<IngredientsRow> getFilteredIngredients() {
    return ingredientsList;
  }
}
