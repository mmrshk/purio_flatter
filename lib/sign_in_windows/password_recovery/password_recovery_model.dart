import '/flutter_flow/flutter_flow_util.dart';
import 'password_recovery_widget.dart' show PasswordRecoveryWidget;
import 'package:flutter/material.dart';

class PasswordRecoveryModel extends FlutterFlowModel<PasswordRecoveryWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=PasswordRecovery',
        searchReference:
            'reference=OhBQYXNzd29yZFJlY292ZXJ5UAFaEFBhc3N3b3JkUmVjb3Zlcnk=',
        widgetClassName: 'PasswordRecovery',
      );
}
