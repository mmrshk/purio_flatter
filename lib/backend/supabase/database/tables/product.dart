import '../database.dart';
import 'dart:convert';

class ProductTable extends SupabaseTable<ProductRow> {
  @override
  String get tableName => 'products';

  @override
  ProductRow createRow(Map<String, dynamic> data) => ProductRow(data);
}

class ProductRow extends SupabaseDataRow {
  ProductRow(super.data);

  @override
  SupabaseTable get table => ProductTable();

  String get id => getField<String>('id')!;

  String get name => getField<String>('name')!;

  String get category => getField<String>('category')!;

  String? get barcode => getField<String>('barcode');

  int? get healthScore {
    final dynamic value = getField<dynamic>('final_score');
    if (value is int) return value;

    return null;
  }
  set healthScore(int? value) => setField<int?>('final_score', value);

  int? get displayScore {
    final dynamic value = getField<dynamic>('display_score');
    if (value is int) return value;

    return null;
  }
  set displayScore(int? value) => setField<int?>('display_score', value);

  String? get imageFrontUrl => getField<String>('image_front_url');
  set imageFrontUrl(String? value) => setField<String>('image_front_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');

  DateTime? get updatedAt => getField<DateTime>('updated_at');

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get supermarketUrl => getField<String>('supermarket_url');
  set supermarketUrl(String? value) => setField<String>('supermarket_url', value);

  List<String>? get additionalImagesUrls => getListField<String>('additional_images_urls');
  set additionalImagesUrls(List<String>? value) => setListField<String>('additional_images_urls', value);

  Map<String, dynamic>? get specifications => getField<Map<String, dynamic>>('specifications');
  set specifications(Map<String, dynamic>? value) => setField<Map<String, dynamic>>('specifications', value);

  Map<String, dynamic>? get nutritional {
    final dynamic value = getField<dynamic>('nutritional');
    if (value == null) return null;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    if (value is String) {
      try {
        final decoded = json.decode(value);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (e) {
        print('Error decoding nutritional JSON: $e');
      }
    }
    return null;
  }
  set nutritional(Map<String, dynamic>? value) => setField<Map<String, dynamic>>('nutritional', value);
}