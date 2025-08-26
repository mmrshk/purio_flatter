import '../database.dart';

class FeedbacksTable extends SupabaseTable<FeedbacksRow> {
  @override
  String get tableName => 'feedbacks';

  @override
  FeedbacksRow createRow(Map<String, dynamic> data) => FeedbacksRow(data);
}

class FeedbacksRow extends SupabaseDataRow {
  FeedbacksRow(super.data);

  @override
  SupabaseTable get table => FeedbacksTable();

  String get id => getField<String>('id')!;

  int get userId => getField<int>('user_id')!;
  set userId(int value) => setField<int>('user_id', value);

  String get feedbackText => getField<String>('feedback_text')!;
  set feedbackText(String value) => setField<String>('feedback_text', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
}
