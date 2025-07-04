import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sing_up_log_in_widget.dart' show SingUpLogInWidget;
import 'package:flutter/material.dart';

class SingUpLogInModel extends FlutterFlowModel<SingUpLogInWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=SingUp-LogIn',
        searchReference: 'reference=OgxTaW5nVXAtTG9nSW5QAVoMU2luZ1VwLUxvZ0lu',
        widgetClassName: 'SingUp-LogIn',
      );
}
