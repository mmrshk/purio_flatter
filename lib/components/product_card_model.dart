import '/flutter_flow/flutter_flow_util.dart';
import 'product_card_widget.dart' show ProductCardWidget;
import 'package:flutter/material.dart';

class ProductCardModel extends FlutterFlowModel<ProductCardWidget> {
  // State for favorites
  bool isFavorite = false;
  bool isLoadingFavorite = false;
  
  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=ProductCard',
        searchReference: 'reference=OgtQcm9kdWN0Q2FyZFAAWgtQcm9kdWN0Q2FyZA==',
        widgetClassName: 'ProductCard',
      );
}
