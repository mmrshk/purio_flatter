import '/components/navbar_widget.dart';
import '/components/product_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'history_widget.dart' show HistoryWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoryModel extends FlutterFlowModel<HistoryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProductCard component.
  late ProductCardModel productCardModel1;
  // Model for ProductCard component.
  late ProductCardModel productCardModel2;
  // Model for ProductCard component.
  late ProductCardModel productCardModel3;
  // Model for ProductCard component.
  late ProductCardModel productCardModel4;
  // Model for ProductCard component.
  late ProductCardModel productCardModel5;
  // Model for ProductCard component.
  late ProductCardModel productCardModel6;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    productCardModel1 = createModel(context, () => ProductCardModel());
    productCardModel2 = createModel(context, () => ProductCardModel());
    productCardModel3 = createModel(context, () => ProductCardModel());
    productCardModel4 = createModel(context, () => ProductCardModel());
    productCardModel5 = createModel(context, () => ProductCardModel());
    productCardModel6 = createModel(context, () => ProductCardModel());
    navbarModel = createModel(context, () => NavbarModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    productCardModel1.dispose();
    productCardModel2.dispose();
    productCardModel3.dispose();
    productCardModel4.dispose();
    productCardModel5.dispose();
    productCardModel6.dispose();
    navbarModel.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'productCardModel1 (ProductCard)':
              productCardModel1?.toWidgetClassDebugData(),
          'productCardModel2 (ProductCard)':
              productCardModel2?.toWidgetClassDebugData(),
          'productCardModel3 (ProductCard)':
              productCardModel3?.toWidgetClassDebugData(),
          'productCardModel4 (ProductCard)':
              productCardModel4?.toWidgetClassDebugData(),
          'productCardModel5 (ProductCard)':
              productCardModel5?.toWidgetClassDebugData(),
          'productCardModel6 (ProductCard)':
              productCardModel6?.toWidgetClassDebugData(),
          'navbarModel (Navbar)': navbarModel?.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=History',
        searchReference: 'reference=OgdIaXN0b3J5UAFaB0hpc3Rvcnk=',
        widgetClassName: 'History',
      );
}
