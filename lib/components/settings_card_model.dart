import '/flutter_flow/flutter_flow_util.dart';
import 'settings_card_widget.dart' show SettingsCardWidget;
import 'package:flutter/material.dart';

class SettingsCardModel extends FlutterFlowModel<SettingsCardWidget> {
  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'icon': debugSerializeParam(
            widget?.icon,
            ParamType.Widget,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=SettingsCard',
            searchReference:
                'reference=ShoKDgoEaWNvbhIGZXJoMzh6cggICyAAKgIwAlAAWgRpY29u',
            name: 'Widget',
            nullable: true,
          ),
          'setting': debugSerializeParam(
            widget?.setting,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=SettingsCard',
            searchReference:
                'reference=ShkKEQoHc2V0dGluZxIGbzl2djFpcgQIAyAAUABaB3NldHRpbmc=',
            name: 'String',
            nullable: true,
          )
        }.withoutNulls,
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=SettingsCard',
        searchReference: 'reference=OgxTZXR0aW5nc0NhcmRQAFoMU2V0dGluZ3NDYXJk',
        widgetClassName: 'SettingsCard',
      );
}
