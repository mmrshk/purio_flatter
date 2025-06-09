import '/flutter_flow/flutter_flow_util.dart';
import 'terms_of_use_widget.dart' show TermsOfUseWidget;
import 'package:flutter/material.dart';

class TermsOfUseModel extends FlutterFlowModel<TermsOfUseWidget> {
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=TermsOfUse',
        searchReference: 'reference=OgpUZXJtc09mVXNlUAFaClRlcm1zT2ZVc2U=',
        widgetClassName: 'TermsOfUse',
      );
}
