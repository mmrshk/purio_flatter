import '../database.dart';

class PendingProductSubmissionTable extends SupabaseTable<PendingProductSubmissionRow> {
  @override
  String get tableName => 'pending_product_submissions';

  @override
  PendingProductSubmissionRow createRow(Map<String, dynamic> data) => PendingProductSubmissionRow(data);
}

class PendingProductSubmissionRow extends SupabaseDataRow {
  PendingProductSubmissionRow(super.data);

  @override
  SupabaseTable get table => PendingProductSubmissionTable();

  String get id => getField<String>('id')!;

  String get barcode => getField<String>('barcode')!;
  set barcode(String value) => setField<String>('barcode', value);

  String? get imageFrontUrl => getField<String>('image_front_url');
  set imageFrontUrl(String? value) => setField<String>('image_front_url', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
}

