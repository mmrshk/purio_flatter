import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import 'recommendations_list_widget.dart' show RecommendationsListWidget;
import 'package:flutter/material.dart';

class RecommendationsListModel extends FlutterFlowModel<RecommendationsListWidget> {
  ///  State fields for stateful widgets in this page.

  // State for recommendations
  List<ProductRow> recommendations = [];
  bool isLoading = false;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=RecommendationsList',
        searchReference: 'reference=Og5Qcm9tbWVuZGF0aW9uc0xpc3RQAFoVUmVjb21tZW5kYXRpb25zTGlzdA==',
        widgetClassName: 'RecommendationsList',
      );
}
