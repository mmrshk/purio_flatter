import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/risk_sorting_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AdditivesScreenModel extends FlutterFlowModel {
  final unfocusNode = FocusNode();
  FocusNode? searchFocusNode;
  TextEditingController? searchController;
  String? Function(BuildContext, String?)? searchControllerValidator;
  ScrollController? listViewController;
  List<AdditivesRow> additivesList = [];
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
    loadAdditives();
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
        loadMoreAdditives();
      }
    }
  }

  Future<void> loadAdditives() async {
    isLoading = true;
    currentOffset = 0;
    hasMoreData = true;
    additivesList.clear();
    onUpdate();

    try {
      final additives = await AdditivesTable().queryRows(
        queryFn: (q) => q
          .order('code')
          .range(currentOffset, currentOffset + batchSize - 1),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Loading additives timed out');
        },
      );
      
      additivesList = RiskSortingService.sortAdditivesByRisk(additives);
      hasMoreData = additives.length == batchSize;
      currentOffset += batchSize;
      isLoading = false;
      onUpdate();
    } catch (e) {
      isLoading = false;
      onUpdate();
    }
  }

  Future<void> loadMoreAdditives() async {
    if (isLoadingMore || !hasMoreData) return;
    
    isLoadingMore = true;
    onUpdate();

    try {
      final additives = await AdditivesTable().queryRows(
        queryFn: (q) => q
          .order('code')
          .range(currentOffset, currentOffset + batchSize - 1),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Loading more additives timed out');
        },
      );
      
      final sortedAdditives = RiskSortingService.sortAdditivesByRisk(additives);
      additivesList.addAll(sortedAdditives);
      hasMoreData = additives.length == batchSize;
      currentOffset += batchSize;
      isLoadingMore = false;
      onUpdate();
    } catch (e) {
      isLoadingMore = false;
      onUpdate();
    }
  }

  Future<void> searchAdditives(String query) async {
    searchQuery = query;
    isLoading = true;
    currentOffset = 0;
    hasMoreData = true;
    additivesList.clear();
    onUpdate();

    if (query.isEmpty) {
      await loadAdditives();
      return;
    }

    try {
      final additives = await AdditivesTable().queryRows(
        queryFn: (q) => q
          .or('code.ilike.%$query%,name.ilike.%$query%,ro_name.ilike.%$query%')
          .order('code')
          .range(currentOffset, currentOffset + batchSize - 1),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Searching additives timed out');
        },
      );
      
      additivesList = RiskSortingService.sortAdditivesByRisk(additives);
      hasMoreData = additives.length == batchSize;
      currentOffset += batchSize;
      isLoading = false;
      onUpdate();
    } catch (e) {
      isLoading = false;
      onUpdate();
    }
  }

  List<AdditivesRow> getFilteredAdditives() {
    return additivesList;
  }

  void updateSearchQuery(String query) {
    _searchDebounce?.cancel();
    
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (query != searchQuery) {
        searchAdditives(query);
      }
    });
  }
}
