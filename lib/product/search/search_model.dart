import '/components/search_product_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_widget.dart' show SearchWidget;
import 'package:flutter/material.dart';

class SearchModel extends FlutterFlowModel<SearchWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SearchProduct component.
  late SearchProductModel searchProductModel1;
  // Model for SearchProduct component.
  late SearchProductModel searchProductModel2;
  // Model for SearchProduct component.
  late SearchProductModel searchProductModel3;
  // Model for SearchProduct component.
  late SearchProductModel searchProductModel4;
  // Model for SearchProduct component.
  late SearchProductModel searchProductModel5;
  // Model for SearchProduct component.
  late SearchProductModel searchProductModel6;
  // Model for SearchProduct component.
  late SearchProductModel searchProductModel7;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    searchProductModel1 = createModel(context, () => SearchProductModel());
    searchProductModel2 = createModel(context, () => SearchProductModel());
    searchProductModel3 = createModel(context, () => SearchProductModel());
    searchProductModel4 = createModel(context, () => SearchProductModel());
    searchProductModel5 = createModel(context, () => SearchProductModel());
    searchProductModel6 = createModel(context, () => SearchProductModel());
    searchProductModel7 = createModel(context, () => SearchProductModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    searchProductModel1.dispose();
    searchProductModel2.dispose();
    searchProductModel3.dispose();
    searchProductModel4.dispose();
    searchProductModel5.dispose();
    searchProductModel6.dispose();
    searchProductModel7.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'searchProductModel1 (SearchProduct)':
              searchProductModel1.toWidgetClassDebugData(),
          'searchProductModel2 (SearchProduct)':
              searchProductModel2.toWidgetClassDebugData(),
          'searchProductModel3 (SearchProduct)':
              searchProductModel3.toWidgetClassDebugData(),
          'searchProductModel4 (SearchProduct)':
              searchProductModel4.toWidgetClassDebugData(),
          'searchProductModel5 (SearchProduct)':
              searchProductModel5.toWidgetClassDebugData(),
          'searchProductModel6 (SearchProduct)':
              searchProductModel6.toWidgetClassDebugData(),
          'searchProductModel7 (SearchProduct)':
              searchProductModel7.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=Search',
        searchReference: 'reference=OgZTZWFyY2hQAVoGU2VhcmNo',
        widgetClassName: 'Search',
      );
}
