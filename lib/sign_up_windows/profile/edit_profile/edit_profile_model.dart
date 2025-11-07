import '/components/settings_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:flutter/material.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel1;
  // Model for SettingsCard component.
  late SettingsCardModel settingsCardModel2;
  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    settingsCardModel1 = createModel(context, () => SettingsCardModel());
    settingsCardModel2 = createModel(context, () => SettingsCardModel());
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    settingsCardModel1.dispose();
    settingsCardModel2.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
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
            'https://app.flutterflow.io/project/scan-app-dkuknp/tab=uiBuilder&page=EditProfile',
        searchReference: 'reference=OgtFZGl0UHJvZmlsZVABWgtFZGl0UHJvZmlsZQ==',
        widgetClassName: 'EditProfile',
      );
}
