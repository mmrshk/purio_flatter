import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'log_in_widget.dart' show LogInWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogInModel extends FlutterFlowModel<LogInWidget> {
  ///  Local state fields for this page.

  bool _loginError = false;
  set loginError(bool value) {
    _loginError = value;
    debugLogWidgetClass(this);
  }

  bool get loginError => _loginError;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    passwordVisibility = false;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    emailTextController?.dispose();

    textFieldFocusNode2?.dispose();
    passwordTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        localStates: {
          'loginError': debugSerializeParam(
            loginError,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=LogIn',
            searchReference:
                'reference=QiQKEwoKbG9naW5FcnJvchIFZTFqN2EqBxIFZmFsc2VyBAgFIAFQAVoKbG9naW5FcnJvcmIFTG9nSW4=',
            name: 'bool',
            nullable: false,
          )
        },
        widgetStates: {
          'textFieldText1': debugSerializeParam(
            emailTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=LogIn',
            name: 'String',
            nullable: true,
          ),
          'textFieldText2': debugSerializeParam(
            passwordTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=LogIn',
            name: 'String',
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=LogIn',
        searchReference: 'reference=OgVMb2dJblABWgVMb2dJbg==',
        widgetClassName: 'LogIn',
      );
}
