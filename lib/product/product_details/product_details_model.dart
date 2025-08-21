import '/components/product_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/backend/supabase/supabase.dart';
import '/services/additives_service.dart';
import '/services/recommendations_service.dart';
import '/services/ingredients_service.dart';
import 'product_details_widget.dart' show ProductDetailsWidget;
import 'package:flutter/material.dart';

class ProductDetailsModel extends FlutterFlowModel<ProductDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProductCard component.
  late ProductCardModel productCardModel;

  // State for ingredients visibility
  int visibleIngredientsCount = 1;
  List<MatchedIngredient> _ingredients = [];
  bool hasMoreIngredients = false;
  String? _rawIngredientsText;
  
  List<MatchedIngredient> get ingredients => _ingredients;
  set ingredients(List<MatchedIngredient> value) {
    _ingredients = value;
  }
  
  String? get rawIngredientsText => _rawIngredientsText;
  set rawIngredientsText(String? value) {
    _rawIngredientsText = value;
  }
  
  // State for additives
  List<AdditivesRow> additives = [];
  bool isLoadingIngredients = false;
  
  // State for recommendations
  ProductRow? recommendedProduct;
  bool isLoadingRecommendations = false;
  
  // State for favorites
  bool isFavorite = false;
  bool isLoadingFavorite = false;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    productCardModel = createModel(context, () => ProductCardModel());
    
    // Ensure ingredients is properly initialized
    _ingredients = [];
    hasMoreIngredients = false;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    productCardModel.dispose();
  }

  Future<void> loadIngredients(Map<String, dynamic>? specifications) async {
    if (specifications == null) {
      _ingredients = [];
      hasMoreIngredients = false;
      return;
    }

    // Get parsed_ingredients from specifications
    Map<String, dynamic>? parsedIngredientsData = specifications['parsed_ingredients'];
    
    if (parsedIngredientsData == null) {
      _ingredients = [];
      _rawIngredientsText = null;
      hasMoreIngredients = false;
      return;
    }

    // Extract raw ingredients text from extracted_ingredients array
    List<dynamic> extractedIngredients = parsedIngredientsData['extracted_ingredients'] ?? [];
    _rawIngredientsText = extractedIngredients.join(', ');

    isLoadingIngredients = true;
    
    try {
      _ingredients = await IngredientsService.parseAndMatchIngredients(parsedIngredientsData);
      int totalIngredientsCount = _ingredients.length;
      hasMoreIngredients = totalIngredientsCount > 1;
    } catch (e) {
      print('Error loading ingredients: $e');
      _ingredients = [];
      hasMoreIngredients = false;
    } finally {
      isLoadingIngredients = false;
    }
  }

  void showMoreIngredients() {
    visibleIngredientsCount += 10;
    int totalIngredientsCount = _ingredients.length;
    if (visibleIngredientsCount > totalIngredientsCount) {
      visibleIngredientsCount = totalIngredientsCount;
    }
    hasMoreIngredients = visibleIngredientsCount < totalIngredientsCount;
  }

  /// Load additives for a product
  Future<void> loadAdditives(String productId, BuildContext context) async {
    try {
      additives = await AdditivesService.getProductAdditives(productId);
    } catch (e) {
      print('Error loading additives: $e');
      additives = [];
    }
  }

  /// Load recommended product
  Future<void> loadRecommendations(String productId, String category) async {
    isLoadingRecommendations = true;
    
    try {
      // First try to get a product in the same category
      recommendedProduct = await RecommendationsService.getBestRatedProductInCategory(category, productId);
      
      // If no product found in the same category, get a general recommendation
      if (recommendedProduct == null) {
        final generalRecommendations = await RecommendationsService.getGeneralRecommendedProducts(productId, limit: 1);
        if (generalRecommendations.isNotEmpty) {
          recommendedProduct = generalRecommendations.first;
        }
      }
    } catch (e) {
      print('Error loading recommendations: $e');
      recommendedProduct = null;
    } finally {
      isLoadingRecommendations = false;
    }
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'productCardModel (ProductCard)':
              productCardModel.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=ProductDetails',
        searchReference:
            'reference=Og5Qcm9kdWN0RGV0YWlsc1ABWg5Qcm9kdWN0RGV0YWlscw==',
        widgetClassName: 'ProductDetails',
      );
}


