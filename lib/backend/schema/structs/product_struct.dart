// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductStruct extends BaseStruct {
  ProductStruct({
    String? productName,
    String? productNameEn,
    String? productQuantity,
    String? productQuantityUnit,
    String? imageSmallUrl,
    int? nutriscoreScore,
  })  : _productName = productName,
        _productNameEn = productNameEn,
        _productQuantity = productQuantity,
        _productQuantityUnit = productQuantityUnit,
        _imageSmallUrl = imageSmallUrl,
        _nutriscoreScore = nutriscoreScore;

  // "product_name" field.
  String? _productName;
  String get productName => _productName ?? '';
  set productName(String? val) {
    _productName = val;
    debugLog();
  }

  bool hasProductName() => _productName != null;

  // "product_name_en" field.
  String? _productNameEn;
  String get productNameEn => _productNameEn ?? '';
  set productNameEn(String? val) {
    _productNameEn = val;
    debugLog();
  }

  bool hasProductNameEn() => _productNameEn != null;

  // "product_quantity" field.
  String? _productQuantity;
  String get productQuantity => _productQuantity ?? '';
  set productQuantity(String? val) {
    _productQuantity = val;
    debugLog();
  }

  bool hasProductQuantity() => _productQuantity != null;

  // "product_quantity_unit" field.
  String? _productQuantityUnit;
  String get productQuantityUnit => _productQuantityUnit ?? '';
  set productQuantityUnit(String? val) {
    _productQuantityUnit = val;
    debugLog();
  }

  bool hasProductQuantityUnit() => _productQuantityUnit != null;

  // "image_small_url" field.
  String? _imageSmallUrl;
  String get imageSmallUrl => _imageSmallUrl ?? '';
  set imageSmallUrl(String? val) {
    _imageSmallUrl = val;
    debugLog();
  }

  bool hasImageSmallUrl() => _imageSmallUrl != null;

  // "nutriscore_score" field.
  int? _nutriscoreScore;
  int get nutriscoreScore => _nutriscoreScore ?? 0;
  set nutriscoreScore(int? val) {
    _nutriscoreScore = val;
    debugLog();
  }

  void incrementNutriscoreScore(int amount) =>
      nutriscoreScore = nutriscoreScore + amount;

  bool hasNutriscoreScore() => _nutriscoreScore != null;

  static ProductStruct fromMap(Map<String, dynamic> data) => ProductStruct(
        productName: data['product_name'] as String?,
        productNameEn: data['product_name_en'] as String?,
        productQuantity: data['product_quantity'] as String?,
        productQuantityUnit: data['product_quantity_unit'] as String?,
        imageSmallUrl: data['image_small_url'] as String?,
        nutriscoreScore: castToType<int>(data['nutriscore_score']),
      );

  static ProductStruct? maybeFromMap(dynamic data) =>
      data is Map ? ProductStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'product_name': _productName,
        'product_name_en': _productNameEn,
        'product_quantity': _productQuantity,
        'product_quantity_unit': _productQuantityUnit,
        'image_small_url': _imageSmallUrl,
        'nutriscore_score': _nutriscoreScore,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'product_name': serializeParam(
          _productName,
          ParamType.String,
        ),
        'product_name_en': serializeParam(
          _productNameEn,
          ParamType.String,
        ),
        'product_quantity': serializeParam(
          _productQuantity,
          ParamType.String,
        ),
        'product_quantity_unit': serializeParam(
          _productQuantityUnit,
          ParamType.String,
        ),
        'image_small_url': serializeParam(
          _imageSmallUrl,
          ParamType.String,
        ),
        'nutriscore_score': serializeParam(
          _nutriscoreScore,
          ParamType.int,
        ),
      }.withoutNulls;

  static ProductStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProductStruct(
        productName: deserializeParam(
          data['product_name'],
          ParamType.String,
          false,
        ),
        productNameEn: deserializeParam(
          data['product_name_en'],
          ParamType.String,
          false,
        ),
        productQuantity: deserializeParam(
          data['product_quantity'],
          ParamType.String,
          false,
        ),
        productQuantityUnit: deserializeParam(
          data['product_quantity_unit'],
          ParamType.String,
          false,
        ),
        imageSmallUrl: deserializeParam(
          data['image_small_url'],
          ParamType.String,
          false,
        ),
        nutriscoreScore: deserializeParam(
          data['nutriscore_score'],
          ParamType.int,
          false,
        ),
      );
  @override
  Map<String, DebugDataField> toDebugSerializableMap() => {
        'product_name': debugSerializeParam(
          productName,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'product_name_en': debugSerializeParam(
          productNameEn,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'product_quantity': debugSerializeParam(
          productQuantity,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'product_quantity_unit': debugSerializeParam(
          productQuantityUnit,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'image_small_url': debugSerializeParam(
          imageSmallUrl,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'nutriscore_score': debugSerializeParam(
          nutriscoreScore,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
      };

  @override
  String toString() => 'ProductStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductStruct &&
        productName == other.productName &&
        productNameEn == other.productNameEn &&
        productQuantity == other.productQuantity &&
        productQuantityUnit == other.productQuantityUnit &&
        imageSmallUrl == other.imageSmallUrl &&
        nutriscoreScore == other.nutriscoreScore;
  }

  @override
  int get hashCode => const ListEquality().hash([
        productName,
        productNameEn,
        productQuantity,
        productQuantityUnit,
        imageSmallUrl,
        nutriscoreScore
      ]);
}

ProductStruct createProductStruct({
  String? productName,
  String? productNameEn,
  String? productQuantity,
  String? productQuantityUnit,
  String? imageSmallUrl,
  int? nutriscoreScore,
}) =>
    ProductStruct(
      productName: productName,
      productNameEn: productNameEn,
      productQuantity: productQuantity,
      productQuantityUnit: productQuantityUnit,
      imageSmallUrl: imageSmallUrl,
      nutriscoreScore: nutriscoreScore,
    );
