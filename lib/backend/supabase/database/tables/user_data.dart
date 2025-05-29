import '../database.dart';

class UserDataTable extends SupabaseTable<UserDataRow> {
  @override
  String get tableName => 'UserData';

  @override
  UserDataRow createRow(Map<String, dynamic> data) => UserDataRow(data);
}

class UserDataRow extends SupabaseDataRow {
  UserDataRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserDataTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get firstName => getField<String>('first_name');
  set firstName(String? value) => setField<String>('first_name', value);

  String? get lastName => getField<String>('last_name');
  set lastName(String? value) => setField<String>('last_name', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  String? get expectations => getField<String>('expectations');
  set expectations(String? value) => setField<String>('expectations', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);
}
