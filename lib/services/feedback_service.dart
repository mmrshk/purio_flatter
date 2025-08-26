import '/backend/supabase/database/database.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

class FeedbackService {
  static Future<bool> saveFeedback(String feedbackText) async {
    try {
      final currentUser = currentUserUid;
      if (currentUser == null) {
        print('No user logged in');
        return false;
      }

      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUser),
      );

      if (userData.isEmpty) {
        print('User data not found');
        return false;
      }

      final userId = userData.first.id;

      await SupaFlow.client
          .from('feedbacks')
          .insert({
            'user_id': userId,
            'feedback_text': feedbackText,
          });

      print('Feedback saved successfully');
      return true;
    } catch (e) {
      print('Error saving feedback: $e');
      return false;
    }
  }
}
