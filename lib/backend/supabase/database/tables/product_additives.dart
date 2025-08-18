import '../database.dart';

class ProductAdditivesTable extends SupabaseTable<ProductAdditivesRow> {
  @override
  String get tableName => 'product_additives';

  @override
  ProductAdditivesRow createRow(Map<String, dynamic> data) => ProductAdditivesRow(data);
}

class ProductAdditivesRow extends SupabaseDataRow {
  ProductAdditivesRow(super.data);

  @override
  SupabaseTable get table => ProductAdditivesTable();

  String get id => getField<String>('id')!;

  DateTime get createdAt => getField<DateTime>('created_at')!;

  String get productId => getField<String>('product_id')!;

  String get additiveId => getField<String>('additive_id')!;
}
