import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/second_question_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'continue2nd_question_widget.dart' show Continue2ndQuestionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Continue2ndQuestionModel
    extends FlutterFlowModel<Continue2ndQuestionWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for SecondQuestion component.
  late SecondQuestionModel secondQuestionModel1;
  // Model for SecondQuestion component.
  late SecondQuestionModel secondQuestionModel2;
  // Model for SecondQuestion component.
  late SecondQuestionModel secondQuestionModel3;
  // Model for SecondQuestion component.
  late SecondQuestionModel secondQuestionModel4;
  // Model for SecondQuestion component.
  late SecondQuestionModel secondQuestionModel5;
  // Model for SecondQuestion component.
  late SecondQuestionModel secondQuestionModel6;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  UserDataRow? _userDataAddResponse;
  set userDataAddResponse(UserDataRow? value) {
    _userDataAddResponse = value;
    debugLogWidgetClass(this);
  }

  UserDataRow? get userDataAddResponse => _userDataAddResponse;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    secondQuestionModel1 = createModel(context, () => SecondQuestionModel());
    secondQuestionModel2 = createModel(context, () => SecondQuestionModel());
    secondQuestionModel3 = createModel(context, () => SecondQuestionModel());
    secondQuestionModel4 = createModel(context, () => SecondQuestionModel());
    secondQuestionModel5 = createModel(context, () => SecondQuestionModel());
    secondQuestionModel6 = createModel(context, () => SecondQuestionModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    secondQuestionModel1.dispose();
    secondQuestionModel2.dispose();
    secondQuestionModel3.dispose();
    secondQuestionModel4.dispose();
    secondQuestionModel5.dispose();
    secondQuestionModel6.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        actionOutputs: {
          'userDataAddResponse': debugSerializeParam(
            userDataAddResponse,
            ParamType.SupabaseRow,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=Continue2ndQuestion',
            name: 'UserData',
            nullable: true,
          )
        },
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'secondQuestionModel1 (SecondQuestion)':
              secondQuestionModel1.toWidgetClassDebugData(),
          'secondQuestionModel2 (SecondQuestion)':
              secondQuestionModel2.toWidgetClassDebugData(),
          'secondQuestionModel3 (SecondQuestion)':
              secondQuestionModel3.toWidgetClassDebugData(),
          'secondQuestionModel4 (SecondQuestion)':
              secondQuestionModel4.toWidgetClassDebugData(),
          'secondQuestionModel5 (SecondQuestion)':
              secondQuestionModel5.toWidgetClassDebugData(),
          'secondQuestionModel6 (SecondQuestion)':
              secondQuestionModel6.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=Continue2ndQuestion',
        searchReference:
            'reference=OhNDb250aW51ZTJuZFF1ZXN0aW9uUAFaE0NvbnRpbnVlMm5kUXVlc3Rpb24=',
        widgetClassName: 'Continue2ndQuestion',
      );
}
