import '../database.dart';

class ProductTable extends SupabaseTable<ProductRow> {
  @override
  String get tableName => 'Products';

  @override
  ProductRow createRow(Map<String, dynamic> data) => ProductRow(data);
}

class ProductRow extends SupabaseDataRow {
  ProductRow(super.data);

  @override
  SupabaseTable get table => ProductTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);

  String? get barcode => getField<String>('barcode');
  set barcode(String? value) => setField<String>('barcode', value);

  int? get healthScore => getField<int>('health_score');
  set healthScore(int? value) => setField<int>('health_score', value);

  String? get imageFrontUrl => getField<String>('image_front_url');
  set imageFrontUrl(String? value) => setField<String>('image_front_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get ingredients => getField<String>('ingredients');
  set ingredients(String? value) => setField<String>('ingredients', value);

  String? get supermarketUrl => getField<String>('supermarket_url');
  set supermarketUrl(String? value) => setField<String>('supermarket_url', value);

  List<String>? get additionalImagesUrls => getListField<String>('additional_images_urls');
  set additionalImagesUrls(List<String>? value) => setListField<String>('additional_images_urls', value);

  Map<String, dynamic>? get specifications => getField<Map<String, dynamic>>('specifications');
  set specifications(Map<String, dynamic>? value) => setField<Map<String, dynamic>>('specifications', value);

  Map<String, dynamic>? get nutritional => getField<Map<String, dynamic>>('nutritional');
  set nutritional(Map<String, dynamic>? value) => setField<Map<String, dynamic>>('nutritional', value);
}