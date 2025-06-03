import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'first_question_widget.dart' show FirstQuestionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FirstQuestionModel extends FlutterFlowModel<FirstQuestionWidget> {
  ///  Local state fields for this component.

  Color? _btnColor = const Color(0xffffffff);
  set btnColor(Color? value) {
    _btnColor = value;
    debugLogWidgetClass(this);
  }

  Color? get btnColor => _btnColor;

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
          'level': debugSerializeParam(
            widget?.level,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=FirstQuestion',
            searchReference:
                'reference=ShcKDwoFbGV2ZWwSBmh2ZGVmeXIECAMgAVAAWgVsZXZlbA==',
            name: 'String',
            nullable: true,
          ),
          'description': debugSerializeParam(
            widget?.description,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=FirstQuestion',
            searchReference:
                'reference=Sh0KFQoLZGVzY3JpcHRpb24SBjA0dThmaXIECAMgAVAAWgtkZXNjcmlwdGlvbg==',
            name: 'String',
            nullable: true,
          ),
          'btnColor': debugSerializeParam(
            widget?.btnColor,
            ParamType.Color,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=FirstQuestion',
            searchReference:
                'reference=ShoKEgoIYnRuQ29sb3ISBjlrcG5lMnIECBYgAFAAWghidG5Db2xvcg==',
            name: 'Color',
            nullable: true,
          )
        }.withoutNulls,
        localStates: {
          'btnColor': debugSerializeParam(
            btnColor,
            ParamType.Color,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=FirstQuestion',
            searchReference:
                'reference=QhcKEQoIYnRuQ29sb3ISBW9lY29rcgIIFlAAWghidG5Db2xvcmINRmlyc3RRdWVzdGlvbg==',
            name: 'Color',
            nullable: true,
          )
        },
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=FirstQuestion',
        searchReference:
            'reference=Og1GaXJzdFF1ZXN0aW9uUABaDUZpcnN0UXVlc3Rpb24=',
        widgetClassName: 'FirstQuestion',
      );
}
