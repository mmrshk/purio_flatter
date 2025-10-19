import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'language_selection_widget.dart' show LanguageSelectionWidget;
import 'package:flutter/material.dart';

class LanguageSelectionModel extends FlutterFlowModel<LanguageSelectionWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=LanguageSelection',
        searchReference: 'reference=LanguageSelection',
        widgetClassName: 'LanguageSelection',
      );
}
