import 'dart:io';

import '/backend/supabase/database/database.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackService {
  static const _storageBucket = 'feedback-images';
  static const _maxUploadSizeBytes = 15 * 1024 * 1024; // 15 MB safety limit

  static Future<bool> saveFeedback({
    required String feedbackText,
    List<File> photos = const [],
  }) async {
    final uploads = <_FeedbackPhotoUpload>[];
    int? feedbackId;
    var feedbackInserted = false;

    try {
      final authUserId = currentUserUid;
      if (authUserId.isEmpty) {
        print('❌ No user logged in');
        return false;
      }

      if (feedbackText.trim().isEmpty && photos.isEmpty) {
        print('❌ Feedback text and photos are both empty');
        return false;
      }

      // Get the current user's internal ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', authUserId),
        limit: 1,
      );

      if (userData.isEmpty) {
        print('❌ User data not found for $authUserId');
        return false;
      }

      final userRowId = userData.first.id;

      final client = SupaFlow.client;

      final sanitizedFeedbackText = feedbackText.trim().isNotEmpty
          ? feedbackText.trim()
          : 'Photo feedback';

      final insertedFeedback = await client
          .from('feedbacks')
          .insert({
            'user_id': userRowId,
            'feedback_text': sanitizedFeedbackText,
          })
          .select('id')
          .maybeSingle();

      final rawId = insertedFeedback?['id'];
      if (rawId is int) {
        feedbackId = rawId;
      } else if (rawId is String) {
        feedbackId = int.tryParse(rawId);
      }

      if (feedbackId == null) {
        print('❌ Failed to obtain feedback ID');
        return false;
      }

      feedbackInserted = true;

      // Upload photos and insert references
      for (var index = 0; index < photos.length; index++) {
        final file = photos[index];
        if (!await file.exists()) {
          print('⚠️ Skipping missing file at ${file.path}');
          continue;
        }

        final fileLength = await file.length();
        if (fileLength > _maxUploadSizeBytes) {
          print('❌ File too large (${fileLength} bytes) for ${file.path}');
          await _cleanupUploadedPhotos(uploads);
          await _deleteFeedbackCascade(feedbackId);
          return false;
        }

        final upload = await _uploadFeedbackPhoto(
          file,
          authUserId,
          index,
        );

        if (upload == null) {
          await _cleanupUploadedPhotos(uploads);
          await _deleteFeedbackCascade(feedbackId);
          return false;
        }

        uploads.add(upload);

        try {
          await client.from('feedback_photo_submissions').insert({
            'feedback_id': feedbackId,
            'image_front_url': upload.publicUrl,
            'status': 'pending',
          });
        } catch (e) {
          print('❌ Error saving photo submission record: $e');
          await _cleanupUploadedPhotos(uploads);
          await _deleteFeedbackCascade(feedbackId);
          return false;
        }
      }

      print('✅ Feedback saved successfully');
      return true;
    } catch (e) {
      print('❌ Error saving feedback: $e');
      await _cleanupUploadedPhotos(uploads);
      if (feedbackInserted) {
        if (feedbackId != null) {
          await _deleteFeedbackCascade(feedbackId);
        }
      }
      return false;
    }
  }

  static Future<_FeedbackPhotoUpload?> _uploadFeedbackPhoto(
    File file,
    String authUserId,
    int index,
  ) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName =
          'feedbacks/$authUserId/${timestamp}_$index.jpg';
      final fileBytes = await file.readAsBytes();

      await SupaFlow.client.storage.from(_storageBucket).uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: false,
            ),
          );

      final publicUrl = SupaFlow.client.storage
          .from(_storageBucket)
          .getPublicUrl(fileName);

      return _FeedbackPhotoUpload(
        storagePath: fileName,
        publicUrl: publicUrl,
      );
    } catch (e) {
      print('❌ Error uploading feedback photo: $e');
      return null;
    }
  }

  static Future<void> _cleanupUploadedPhotos(
    List<_FeedbackPhotoUpload> uploads,
  ) async {
    if (uploads.isEmpty) {
      return;
    }

    try {
      final paths = uploads.map((upload) => upload.storagePath).toList();
      await SupaFlow.client.storage.from(_storageBucket).remove(paths);
      print('🧹 Cleaned up ${paths.length} uploaded feedback photos');
    } catch (e) {
      print('⚠️ Failed to clean up uploaded feedback photos: $e');
    }
  }

  static Future<void> _deleteFeedbackCascade(int feedbackId) async {
    try {
      await SupaFlow.client
          .from('feedback_photo_submissions')
          .delete()
          .eq('feedback_id', feedbackId);
    } catch (e) {
      print('⚠️ Failed to delete photo submissions for feedback $feedbackId: $e');
    }

    try {
      await SupaFlow.client
          .from('feedbacks')
          .delete()
          .eq('id', feedbackId);
    } catch (e) {
      print('⚠️ Failed to delete feedback $feedbackId after error: $e');
    }
  }
}

class _FeedbackPhotoUpload {
  const _FeedbackPhotoUpload({
    required this.storagePath,
    required this.publicUrl,
  });

  final String storagePath;
  final String publicUrl;
}
