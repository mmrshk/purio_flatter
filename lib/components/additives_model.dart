import '/flutter_flow/flutter_flow_util.dart';
import 'additives_widget.dart' show AdditivesWidget;
import 'package:flutter/material.dart';

class AdditivesModel extends FlutterFlowModel<AdditivesWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=Additives',
        searchReference: 'reference=OglBZGRpdGl2ZXNQAFoJQWRkaXRpdmVz',
        widgetClassName: 'Additives',
      );
}
