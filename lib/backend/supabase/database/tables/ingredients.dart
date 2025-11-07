import '../database.dart';

class IngredientsTable extends SupabaseTable<IngredientsRow> {
  @override
  String get tableName => 'ingredients';

  @override
  IngredientsRow createRow(Map<String, dynamic> data) => IngredientsRow(data);
}

class IngredientsRow extends SupabaseDataRow {
  IngredientsRow(super.data);

  @override
  SupabaseTable get table => IngredientsTable();

  String get id => getField<String>('id')!;

  DateTime get createdAt => getField<DateTime>('created_at')!;

  String get name => getField<String>('name')!;

  String? get roName => getField<String>('ro_name');

  int? get novaScore => getField<int>('nova_score');

  String? get riskLevel => getField<String>('risk_level');

  String? get description => getField<String>('description');

  String? get roDescription => getField<String>('ro_description');
}
