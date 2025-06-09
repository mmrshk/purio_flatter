import '/components/first_question_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'continue1st_question_widget.dart' show Continue1stQuestionWidget;
import 'package:flutter/material.dart';

class Continue1stQuestionModel
    extends FlutterFlowModel<Continue1stQuestionWidget> {
  ///  Local state fields for this page.

  String? _selectedLevel;
  set selectedLevel(String? value) {
    _selectedLevel = value;
    debugLogWidgetClass(this);
  }

  String? get selectedLevel => _selectedLevel;

  Color _selectedBtnColor = const Color(0xffffffff);
  set selectedBtnColor(Color value) {
    _selectedBtnColor = value;
    debugLogWidgetClass(this);
  }

  Color get selectedBtnColor => _selectedBtnColor;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for FirstQuestion component.
  late FirstQuestionModel firstQuestionModel1;
  // Model for FirstQuestion component.
  late FirstQuestionModel firstQuestionModel2;
  // Model for FirstQuestion component.
  late FirstQuestionModel firstQuestionModel3;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    firstQuestionModel1 = createModel(context, () => FirstQuestionModel());
    firstQuestionModel2 = createModel(context, () => FirstQuestionModel());
    firstQuestionModel3 = createModel(context, () => FirstQuestionModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    firstQuestionModel1.dispose();
    firstQuestionModel2.dispose();
    firstQuestionModel3.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        localStates: {
          'selectedLevel': debugSerializeParam(
            selectedLevel,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=Continue1stQuestion',
            searchReference:
                'reference=QiIKFgoNc2VsZWN0ZWRMZXZlbBIFeTFveDQqAhIAcgQIAyAAUAFaDXNlbGVjdGVkTGV2ZWxiE0NvbnRpbnVlMXN0UXVlc3Rpb24=',
            name: 'String',
            nullable: true,
          ),
          'selectedBtnColor': debugSerializeParam(
            selectedBtnColor,
            ParamType.Color,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=Continue1stQuestion',
            searchReference:
                'reference=QiEKGQoQc2VsZWN0ZWRCdG5Db2xvchIFYmttN2dyBAgWIAFQAVoQc2VsZWN0ZWRCdG5Db2xvcmITQ29udGludWUxc3RRdWVzdGlvbg==',
            name: 'Color',
            nullable: false,
          )
        },
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'firstQuestionModel1 (FirstQuestion)':
              firstQuestionModel1.toWidgetClassDebugData(),
          'firstQuestionModel2 (FirstQuestion)':
              firstQuestionModel2.toWidgetClassDebugData(),
          'firstQuestionModel3 (FirstQuestion)':
              firstQuestionModel3.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=Continue1stQuestion',
        searchReference:
            'reference=OhNDb250aW51ZTFzdFF1ZXN0aW9uUAFaE0NvbnRpbnVlMXN0UXVlc3Rpb24=',
        widgetClassName: 'Continue1stQuestion',
      );
}
