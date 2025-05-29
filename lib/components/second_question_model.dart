import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'second_question_widget.dart' show SecondQuestionWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SecondQuestionModel extends FlutterFlowModel<SecondQuestionWidget> {
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
          'image': debugSerializeParam(
            widget?.image,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=SecondQuestion',
            searchReference:
                'reference=ShcKDwoFaW1hZ2USBmFnMjdrdnIECAQgAFAAWgVpbWFnZQ==',
            name: 'String',
            nullable: true,
          ),
          'description': debugSerializeParam(
            widget?.description,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=SecondQuestion',
            searchReference:
                'reference=Sh0KFQoLZGVzY3JpcHRpb24SBnJiZ2FyeXIECAMgAVAAWgtkZXNjcmlwdGlvbg==',
            name: 'String',
            nullable: true,
          ),
          'expectation': debugSerializeParam(
            widget?.expectation,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=SecondQuestion',
            searchReference:
                'reference=Sh0KFQoLZXhwZWN0YXRpb24SBm01ZjI5ZnIECAMgAVAAWgtleHBlY3RhdGlvbg==',
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=SecondQuestion',
        searchReference:
            'reference=Og5TZWNvbmRRdWVzdGlvblAAWg5TZWNvbmRRdWVzdGlvbg==',
        widgetClassName: 'SecondQuestion',
      );
}
