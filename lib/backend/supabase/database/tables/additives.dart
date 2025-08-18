import '../database.dart';

class AdditivesTable extends SupabaseTable<AdditivesRow> {
  @override
  String get tableName => 'additives';

  @override
  AdditivesRow createRow(Map<String, dynamic> data) => AdditivesRow(data);
}

class AdditivesRow extends SupabaseDataRow {
  AdditivesRow(super.data);

  @override
  SupabaseTable get table => AdditivesTable();

  String get id => getField<String>('id')!;

  DateTime get createdAt => getField<DateTime>('created_at')!;

  String get code => getField<String>('code')!;

  String? get description => getField<String>('description');

  String? get roDescription => getField<String>('ro_description');

  String? get riskLevel => getField<String>('risk_level');

  String get name => getField<String>('name')!;

  String get roName => getField<String>('ro_name')!;
}
