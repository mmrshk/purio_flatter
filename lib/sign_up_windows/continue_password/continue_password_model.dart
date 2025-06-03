import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'continue_password_widget.dart' show ContinuePasswordWidget;
import 'package:flutter/material.dart';

class ContinuePasswordModel extends FlutterFlowModel<ContinuePasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for PasswordTextField widget.
  FocusNode? passwordTextFieldFocusNode;
  TextEditingController? passwordTextFieldTextController;
  late bool passwordTextFieldVisibility;
  String? Function(BuildContext, String?)?
      passwordTextFieldTextControllerValidator;
  // State field(s) for ConfirmPasswordTextField widget.
  FocusNode? confirmPasswordTextFieldFocusNode;
  TextEditingController? confirmPasswordTextFieldTextController;
  late bool confirmPasswordTextFieldVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordTextFieldTextControllerValidator;
  // State field(s) for AcceptSwitch widget.
  bool? _acceptSwitchValue;
  set acceptSwitchValue(bool? value) {
    _acceptSwitchValue = value;
    debugLogWidgetClass(this);
  }

  bool? get acceptSwitchValue => _acceptSwitchValue;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    passwordTextFieldVisibility = false;
    confirmPasswordTextFieldVisibility = false;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    passwordTextFieldFocusNode?.dispose();
    passwordTextFieldTextController?.dispose();

    confirmPasswordTextFieldFocusNode?.dispose();
    confirmPasswordTextFieldTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'userEmail': debugSerializeParam(
            widget?.userEmail,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=ContinuePassword',
            searchReference:
                'reference=ShsKEwoJdXNlckVtYWlsEgZub3YweGRyBAgDIAFQAVoJdXNlckVtYWls',
            name: 'String',
            nullable: true,
          )
        }.withoutNulls,
        widgetStates: {
          'passwordTextFieldText': debugSerializeParam(
            passwordTextFieldTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=ContinuePassword',
            name: 'String',
            nullable: true,
          ),
          'confirmPasswordTextFieldText': debugSerializeParam(
            confirmPasswordTextFieldTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=ContinuePassword',
            name: 'String',
            nullable: true,
          ),
          'acceptSwitchValue': debugSerializeParam(
            acceptSwitchValue,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=ContinuePassword',
            name: 'bool',
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=ContinuePassword',
        searchReference:
            'reference=OhBDb250aW51ZVBhc3N3b3JkUAFaEENvbnRpbnVlUGFzc3dvcmQ=',
        widgetClassName: 'ContinuePassword',
      );
}
