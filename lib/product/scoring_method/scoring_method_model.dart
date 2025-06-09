import '/flutter_flow/flutter_flow_util.dart';
import 'scoring_method_widget.dart' show ScoringMethodWidget;
import 'package:flutter/material.dart';

class ScoringMethodModel extends FlutterFlowModel<ScoringMethodWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=ScoringMethod',
        searchReference:
            'reference=Og1TY29yaW5nTWV0aG9kUAFaDVNjb3JpbmdNZXRob2Q=',
        widgetClassName: 'ScoringMethod',
      );
}
