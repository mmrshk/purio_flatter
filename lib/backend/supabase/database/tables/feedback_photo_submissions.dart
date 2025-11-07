import '../database.dart';

class FeedbackPhotoSubmissionsTable
    extends SupabaseTable<FeedbackPhotoSubmissionsRow> {
  @override
  String get tableName => 'feedback_photo_submissions';

  @override
  FeedbackPhotoSubmissionsRow createRow(Map<String, dynamic> data) =>
      FeedbackPhotoSubmissionsRow(data);
}

class FeedbackPhotoSubmissionsRow extends SupabaseDataRow {
  FeedbackPhotoSubmissionsRow(super.data);

  @override
  SupabaseTable get table => FeedbackPhotoSubmissionsTable();

  String get id => getField<String>('id')!;

  int get feedbackId => getField<int>('feedback_id')!;
  set feedbackId(int value) => setField<int>('feedback_id', value);

  String? get imageFrontUrl => getField<String>('image_front_url');
  set imageFrontUrl(String? value) =>
      setField<String>('image_front_url', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}


