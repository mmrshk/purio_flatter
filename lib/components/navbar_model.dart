import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'navbar_widget.dart' show NavbarWidget;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavbarModel extends FlutterFlowModel<NavbarWidget> {
  ///  State fields for stateful widgets in this component.

  var barcodeValue = '';
  // Stores action output result for [Backend Call - API (Open Food Facts API)] action in Container widget.
  ApiCallResponse? _apiResultOpenFoods;
  set apiResultOpenFoods(ApiCallResponse? value) {
    _apiResultOpenFoods = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get apiResultOpenFoods => _apiResultOpenFoods;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        actionOutputs: {
          'barcodeValue': debugSerializeParam(
            barcodeValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=Navbar',
            name: 'String',
            nullable: true,
          ),
          'apiResultOpenFoods': debugSerializeParam(
            apiResultOpenFoods,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/scan-app-dkuknp?tab=uiBuilder&page=Navbar',
            name: 'ApiCallResponse',
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=Navbar',
        searchReference: 'reference=OgZOYXZiYXJQAFoGTmF2YmFy',
        widgetClassName: 'Navbar',
      );
}
