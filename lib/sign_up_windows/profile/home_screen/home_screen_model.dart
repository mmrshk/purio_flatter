import '/backend/supabase/supabase.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_screen_widget.dart' show HomeScreenWidget;
import 'package:flutter/material.dart';

class HomeScreenModel extends FlutterFlowModel<HomeScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<UserDataRow>? userDataResponse;
  List<ProductRow>? randomProducts;
  // Model for Navbar component.
  late NavbarModel navbarModel;
  bool isLoading = true;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    navbarModel.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        actionOutputs: {
          'userDataResponse': debugSerializeParam(
            userDataResponse,
            ParamType.SupabaseRow,
            isList: true,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=HomeScreen',
            name: 'UserData',
            nullable: true,
          )
        },
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'navbarModel (Navbar)': navbarModel.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=HomeScreen',
        searchReference: 'reference=OgpIb21lU2NyZWVuUAFaCkhvbWVTY3JlZW4=',
        widgetClassName: 'HomeScreen',
      );
}
