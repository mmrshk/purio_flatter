import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '/flutter_flow/flutter_flow_util.dart';

export 'package:collection/collection.dart' show ListEquality;
export 'package:flutter/material.dart' show Color, Colors;
export 'package:from_css_color/from_css_color.dart';

typedef StructBuilder<T> = T Function(Map<String, dynamic> data);

abstract class BaseStruct with DebugLoggable {
  Map<String, dynamic> toSerializableMap();
  String serialize() => json.encode(toSerializableMap());
  Map<String, DebugDataField> toDebugSerializableMap();
}

dynamic deserializeStructParam<T>(
  dynamic param,
  ParamType paramType,
  bool isList, {
  required StructBuilder<T> structBuilder,
}) {
  if (param == null) {
    return null;
  } else if (isList) {
    final paramValues;
    try {
      paramValues = param is Iterable ? param : json.decode(param);
    } catch (e) {
      return null;
    }
    if (paramValues is! Iterable) {
      return null;
    }
    return paramValues
        .map<T>((e) => deserializeStructParam<T>(e, paramType, false,
            structBuilder: structBuilder))
        .toList();
  } else if (param is Map<String, dynamic>) {
    return structBuilder(param);
  } else {
    return deserializeParam<T>(
      param,
      paramType,
      isList,
      structBuilder: structBuilder,
    );
  }
}

List<T>? getStructList<T>(
  dynamic value,
  StructBuilder<T> structBuilder,
) =>
    value is! List
        ? null
        : value
            .whereType<Map<String, dynamic>>()
            .map((e) => structBuilder(e))
            .toList();

Color? getSchemaColor(dynamic value) => value is String
    ? fromCssColor(value)
    : value is Color
        ? value
        : null;

List<Color>? getColorsList(dynamic value) =>
    value is! List ? null : value.map(getSchemaColor).withoutNulls;

List<T>? getDataList<T>(dynamic value) =>
    value is! List ? null : value.map((e) => castToType<T>(e)!).toList();
