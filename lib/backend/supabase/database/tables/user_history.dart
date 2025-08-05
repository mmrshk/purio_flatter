import '../database.dart';

class UserHistoryTable extends SupabaseTable<UserHistoryRow> {
  @override
  String get tableName => 'user_history';

  @override
  UserHistoryRow createRow(Map<String, dynamic> data) => UserHistoryRow(data);
}

class UserHistoryRow extends SupabaseDataRow {
  UserHistoryRow(super.data);

  @override
  SupabaseTable get table => UserHistoryTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get productId => getField<String>('product_id')!;
  set productId(String value) => setField<String>('product_id', value);

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);
} 