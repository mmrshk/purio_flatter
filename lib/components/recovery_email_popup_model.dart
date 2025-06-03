import '/flutter_flow/flutter_flow_util.dart';
import 'recovery_email_popup_widget.dart' show RecoveryEmailPopupWidget;
import 'package:flutter/material.dart';

class RecoveryEmailPopupModel
    extends FlutterFlowModel<RecoveryEmailPopupWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=RecoveryEmailPopup',
        searchReference:
            'reference=OhJSZWNvdmVyeUVtYWlsUG9wdXBQAFoSUmVjb3ZlcnlFbWFpbFBvcHVw',
        widgetClassName: 'RecoveryEmailPopup',
      );
}
