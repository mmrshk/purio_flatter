import '/components/product_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'product_details_widget.dart' show ProductDetailsWidget;
import 'package:flutter/material.dart';

class ProductDetailsModel extends FlutterFlowModel<ProductDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProductCard component.
  late ProductCardModel productCardModel;

  // State for ingredients visibility
  int visibleIngredientsCount = 1;
  List<String> ingredients = [];
  bool hasMoreIngredients = false;
  
  // State for favorites
  bool isFavorite = false;
  bool isLoadingFavorite = false;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    productCardModel = createModel(context, () => ProductCardModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    productCardModel.dispose();
  }

  void loadIngredients(String? ingredientsStr) {
    if (ingredientsStr == null || ingredientsStr.isEmpty) {
      ingredients = [];
      hasMoreIngredients = false;
      return;
    }
    
    // Split ingredients by comma, but not if inside parentheses or part of a decimal number
    List<String> result = [];
    String current = '';
    int parenthesesCount = 0;
    bool isParentheticalText = false;
    
    for (int i = 0; i < ingredientsStr.length; i++) {
      String char = ingredientsStr[i];
      if (char == '(') {
        parenthesesCount++;
        isParentheticalText = true;
        current += char;
      } else if (char == ')') {
        parenthesesCount--;
        current += char;
        if (parenthesesCount == 0) {
          isParentheticalText = false;
        }
      } else if (char == ',' && parenthesesCount == 0 && !isParentheticalText) {
        // Check if this comma is part of a decimal number
        bool isDecimalComma = false;
        if (i > 0 && i < ingredientsStr.length - 1) {
          // Look for pattern like "0, 025%" or "0,025%"
          String prevChar = ingredientsStr[i - 1];
          String nextChar = ingredientsStr[i + 1];
          if (prevChar == '0' && (nextChar == ' ' || nextChar == '0')) {
            isDecimalComma = true;
          }
        }
        
        if (!isDecimalComma) {
          // Only split on comma if we're not inside parentheses and it's not a decimal comma
          if (current.trim().isNotEmpty) {
            // Capitalize first letter and remove trailing dot
            String ingredient = current.trim();
            if (ingredient.isNotEmpty) {
              ingredient = ingredient[0].toUpperCase() + ingredient.substring(1);
              // Remove trailing dot if present
              if (ingredient.endsWith('.')) {
                ingredient = ingredient.substring(0, ingredient.length - 1);
              }
            }
            // If the last ingredient starts with '(', append to previous
            if (ingredient.startsWith('(') && result.isNotEmpty) {
              result[result.length - 1] = result[result.length - 1] + ' ' + ingredient;
            } else {
              result.add(ingredient);
            }
          }
          current = '';
        } else {
          current += char;
        }
      } else {
        current += char;
      }
    }
    
    // Add the last ingredient if there is one
    if (current.trim().isNotEmpty) {
      String ingredient = current.trim();
      if (ingredient.isNotEmpty) {
        ingredient = ingredient[0].toUpperCase() + ingredient.substring(1);
        // Remove trailing dot if present
        if (ingredient.endsWith('.')) {
          ingredient = ingredient.substring(0, ingredient.length - 1);
        }
      }
      // If the last ingredient starts with '(', append to previous
      if (ingredient.startsWith('(') && result.isNotEmpty) {
        result[result.length - 1] = result[result.length - 1] + ' ' + ingredient;
      } else {
        result.add(ingredient);
      }
    }
    
    ingredients = result;
    hasMoreIngredients = ingredients.length > 1;
  }

  void showMoreIngredients() {
    visibleIngredientsCount += 10;
    if (visibleIngredientsCount > ingredients.length) {
      visibleIngredientsCount = ingredients.length;
    }
    hasMoreIngredients = visibleIngredientsCount < ingredients.length;
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
