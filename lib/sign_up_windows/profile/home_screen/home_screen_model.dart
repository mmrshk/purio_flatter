import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'home_screen_widget.dart' show HomeScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreenModel extends FlutterFlowModel<HomeScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in HomeScreen widget.
  List<UserDataRow>? _userDataResponse;
  set userDataResponse(List<UserDataRow>? value) {
    _userDataResponse = value;
    debugLogWidgetClass(this);
  }

  List<UserDataRow>? get userDataResponse => _userDataResponse;

  // Model for Navbar component.
  late NavbarModel navbarModel;

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
          'navbarModel (Navbar)': navbarModel?.toWidgetClassDebugData(),
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
