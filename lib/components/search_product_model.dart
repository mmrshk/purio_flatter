import '/flutter_flow/flutter_flow_util.dart';
import 'search_product_widget.dart' show SearchProductWidget;
import 'package:flutter/material.dart';

class SearchProductModel extends FlutterFlowModel<SearchProductWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=SearchProduct',
        searchReference:
            'reference=Og1TZWFyY2hQcm9kdWN0UABaDVNlYXJjaFByb2R1Y3Q=',
        widgetClassName: 'SearchProduct',
      );
}
