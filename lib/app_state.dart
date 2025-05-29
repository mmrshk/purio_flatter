import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _recent = false;
  bool get recent => _recent;
  set recent(bool value) {
    _recent = value;

    debugLogAppState(this);
  }

  String _favourites = '';
  String get favourites => _favourites;
  set favourites(String value) {
    _favourites = value;

    debugLogAppState(this);
  }

  String _level = '';
  String get level => _level;
  set level(String value) {
    _level = value;

    debugLogAppState(this);
  }

  late LoggableList<String> _expectations = LoggableList([]);
  List<String> get expectations =>
      _expectations?..logger = () => debugLogAppState(this);
  set expectations(List<String> value) {
    if (value != null) {
      _expectations = LoggableList(value);
    }

    debugLogAppState(this);
  }

  void addToExpectations(String value) {
    expectations.add(value);
  }

  void removeFromExpectations(String value) {
    expectations.remove(value);
  }

  void removeAtIndexFromExpectations(int index) {
    expectations.removeAt(index);
  }

  void updateExpectationsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    expectations[index] = updateFn(_expectations[index]);
  }

  void insertAtIndexInExpectations(int index, String value) {
    expectations.insert(index, value);
  }

  String _expectation = '';
  String get expectation => _expectation;
  set expectation(String value) {
    _expectation = value;

    debugLogAppState(this);
  }

  String _firstName = '';
  String get firstName => _firstName;
  set firstName(String value) {
    _firstName = value;

    debugLogAppState(this);
  }

  String _lastName = '';
  String get lastName => _lastName;
  set lastName(String value) {
    _lastName = value;

    debugLogAppState(this);
  }

  Map<String, DebugDataField> toDebugSerializableMap() => {
        'recent': debugSerializeParam(
          recent,
          ParamType.bool,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChgKEgoGcmVjZW50EghtcDJlN25sOHICCAVaBnJlY2VudA==',
          name: 'bool',
          nullable: false,
        ),
        'favourites': debugSerializeParam(
          favourites,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChwKFgoKZmF2b3VyaXRlcxIIbGlncG5kcHhyAggDWgpmYXZvdXJpdGVz',
          name: 'String',
          nullable: false,
        ),
        'level': debugSerializeParam(
          level,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChcKEQoFbGV2ZWwSCG9nMHVqbTF3cgIIA1oFbGV2ZWw=',
          name: 'String',
          nullable: false,
        ),
        'expectations': debugSerializeParam(
          expectations,
          ParamType.String,
          isList: true,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CiAKGAoMZXhwZWN0YXRpb25zEggyaDVmYXFrZ3IEEgIIA1oMZXhwZWN0YXRpb25z',
          name: 'String',
          nullable: false,
        ),
        'expectation': debugSerializeParam(
          expectation,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=Ch0KFwoLZXhwZWN0YXRpb24SCGx1aWFobWFqcgIIA1oLZXhwZWN0YXRpb24=',
          name: 'String',
          nullable: false,
        ),
        'firstName': debugSerializeParam(
          firstName,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChsKFQoJZmlyc3ROYW1lEggzaWI2d2wzb3ICCANaCWZpcnN0TmFtZQ==',
          name: 'String',
          nullable: false,
        ),
        'lastName': debugSerializeParam(
          lastName,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/scan-app-dkuknp?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChoKFAoIbGFzdE5hbWUSCHgyaG1heHVpcgIIA1oIbGFzdE5hbWU=',
          name: 'String',
          nullable: false,
        )
      };
}
