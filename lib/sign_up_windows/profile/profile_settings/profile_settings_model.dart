import '/components/navbar_widget.dart';
import '/components/settings_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'profile_settings_widget.dart' show ProfileSettingsWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingsModel extends FlutterFlowModel<ProfileSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel1;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel2;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel3;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel4;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel5;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel6;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel7;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel8;
  // Model for Navbar component.
  late NavbarModel navbarModel;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    settingsCardModel1 = createModel(context, () => SettingsCardModel());
    settingsCardModel2 = createModel(context, () => SettingsCardModel());
    settingsCardModel3 = createModel(context, () => SettingsCardModel());
    settingsCardModel4 = createModel(context, () => SettingsCardModel());
    settingsCardModel5 = createModel(context, () => SettingsCardModel());
    settingsCardModel6 = createModel(context, () => SettingsCardModel());
    settingsCardModel7 = createModel(context, () => SettingsCardModel());
    settingsCardModel8 = createModel(context, () => SettingsCardModel());
    navbarModel = createModel(context, () => NavbarModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    settingsCardModel1.dispose();
    settingsCardModel2.dispose();
    settingsCardModel3.dispose();
    settingsCardModel4.dispose();
    settingsCardModel5.dispose();
    settingsCardModel6.dispose();
    settingsCardModel7.dispose();
    settingsCardModel8.dispose();
    navbarModel.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'settingsCardModel1 (SettingsCard)':
              settingsCardModel1.toWidgetClassDebugData(),
          'settingsCardModel2 (SettingsCard)':
              settingsCardModel2.toWidgetClassDebugData(),
          'settingsCardModel3 (SettingsCard)':
              settingsCardModel3.toWidgetClassDebugData(),
          'settingsCardModel4 (SettingsCard)':
              settingsCardModel4.toWidgetClassDebugData(),
          'settingsCardModel5 (SettingsCard)':
              settingsCardModel5.toWidgetClassDebugData(),
          'settingsCardModel6 (SettingsCard)':
              settingsCardModel6.toWidgetClassDebugData(),
          'settingsCardModel7 (SettingsCard)':
              settingsCardModel7.toWidgetClassDebugData(),
          'settingsCardModel8 (SettingsCard)':
              settingsCardModel8.toWidgetClassDebugData(),
          'navbarModel (Navbar)': navbarModel.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=ProfileSettings',
        searchReference:
            'reference=Og9Qcm9maWxlU2V0dGluZ3NQAVoPUHJvZmlsZVNldHRpbmdz',
        widgetClassName: 'ProfileSettings',
      );
}
