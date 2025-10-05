import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'continue_account_details_widget.dart' show ContinueAccountDetailsWidget;
import 'package:flutter/material.dart';

class ContinueAccountDetailsModel
    extends FlutterFlowModel<ContinueAccountDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(String?)? textController2Validator;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  // Validation state
  bool _firstNameError = false;
  bool _lastNameError = false;
  
  bool get firstNameError => _firstNameError;
  bool get lastNameError => _lastNameError;
  
  set firstNameError(bool value) => _firstNameError = value;
  set lastNameError(bool value) => _lastNameError = value;
  
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
    
    // Initialize validators
    textController1Validator = (val) {
      if (val == null || val.isEmpty) {
        _firstNameError = true;
        return 'First name is required';
      }
      _firstNameError = false;
      return null;
    };
    
    textController2Validator = (val) {
      if (val == null || val.isEmpty) {
        _lastNameError = true;
        return 'Last name is required';
      }
      _lastNameError = false;
      return null;
    };
  }
  
  bool validateForm() {
    // Check if fields are empty
    final firstNameValid = textController1?.text.trim().isNotEmpty ?? false;
    final lastNameValid = textController2?.text.trim().isNotEmpty ?? false;
    
    _firstNameError = !firstNameValid;
    _lastNameError = !lastNameValid;
    
    return firstNameValid && lastNameValid;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'textFieldText1': debugSerializeParam(
            textController1?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=ContinueAccountDetails',
            name: 'String',
            nullable: true,
          ),
          'textFieldText2': debugSerializeParam(
            textController2?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=ContinueAccountDetails',
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=ContinueAccountDetails',
        searchReference:
            'reference=OhZDb250aW51ZUFjY291bnREZXRhaWxzUAFaFkNvbnRpbnVlQWNjb3VudERldGFpbHM=',
        widgetClassName: 'ContinueAccountDetails',
      );
}
