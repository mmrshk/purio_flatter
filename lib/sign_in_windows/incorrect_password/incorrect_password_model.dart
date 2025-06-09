import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'incorrect_password_widget.dart' show IncorrectPasswordWidget;
import 'package:flutter/material.dart';

class IncorrectPasswordModel extends FlutterFlowModel<IncorrectPasswordWidget> {
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
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=IncorrectPassword',
            searchReference:
                'reference=QiQKEwoKbG9naW5FcnJvchIFZTFqN2EqBxIFZmFsc2VyBAgFIAFQAVoKbG9naW5FcnJvcmIRSW5jb3JyZWN0UGFzc3dvcmQ=',
            name: 'bool',
            nullable: false,
          )
        },
        widgetStates: {
          'textFieldText1': debugSerializeParam(
            emailTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=IncorrectPassword',
            name: 'String',
            nullable: true,
          ),
          'textFieldText2': debugSerializeParam(
            passwordTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=IncorrectPassword',
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=IncorrectPassword',
        searchReference:
            'reference=OhFJbmNvcnJlY3RQYXNzd29yZFABWhFJbmNvcnJlY3RQYXNzd29yZA==',
        widgetClassName: 'IncorrectPassword',
      );
}
