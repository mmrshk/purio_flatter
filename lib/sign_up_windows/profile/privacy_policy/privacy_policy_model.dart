import '/flutter_flow/flutter_flow_util.dart';
import 'privacy_policy_widget.dart' show PrivacyPolicyWidget;
import 'package:flutter/material.dart';

class PrivacyPolicyModel extends FlutterFlowModel<PrivacyPolicyWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=PrivacyPolicy',
        searchReference:
            'reference=Og1Qcml2YWN5UG9saWN5UAFaDVByaXZhY3lQb2xpY3k=',
        widgetClassName: 'PrivacyPolicy',
      );
}
