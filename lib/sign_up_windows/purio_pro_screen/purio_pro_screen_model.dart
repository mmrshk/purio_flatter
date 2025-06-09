import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'purio_pro_screen_widget.dart' show PurioProScreenWidget;
import 'package:flutter/material.dart';

class PurioProScreenModel extends FlutterFlowModel<PurioProScreenWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=PurioProScreen',
        searchReference:
            'reference=Og5QdXJpb1Byb1NjcmVlblABWg5QdXJpb1Byb1NjcmVlbg==',
        widgetClassName: 'PurioProScreen',
      );
}
