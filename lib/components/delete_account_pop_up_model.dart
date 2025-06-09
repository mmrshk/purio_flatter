import '/flutter_flow/flutter_flow_util.dart';
import 'delete_account_pop_up_widget.dart' show DeleteAccountPopUpWidget;
import 'package:flutter/material.dart';

class DeleteAccountPopUpModel
    extends FlutterFlowModel<DeleteAccountPopUpWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=DeleteAccountPopUp',
        searchReference:
            'reference=OhJEZWxldGVBY2NvdW50UG9wVXBQAFoSRGVsZXRlQWNjb3VudFBvcFVw',
        widgetClassName: 'DeleteAccountPopUp',
      );
}
