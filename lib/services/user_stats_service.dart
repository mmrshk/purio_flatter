import '/backend/supabase/supabase.dart';

class UserStatsService {
  static UserStatsService? _instance;
  static UserStatsService get instance => _instance ??= UserStatsService._();
  
  UserStatsService._();

  /// Get user's scan count from user_history table
  Future<int> getScanCount() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return 0;

      // Get user's internal ID from users table
      final userData = await Supabase.instance.client
          .from('users')
          .select('id')
          .eq('user_id', user.id)
          .single();

      final internalUserId = userData['id'] as int;

      final result = await Supabase.instance.client
          .from('user_history')
          .select('id')
          .eq('user_id', internalUserId);

      return result.length;
    } catch (e) {
      print('Error fetching scan count: $e');
      return 0;
    }
  }

  /// Get user's current streak from user_history table
  /// A streak is consecutive days with at least one scan
  Future<int> getCurrentStreak() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return 0;

      // Get user's internal ID from users table
      final userData = await Supabase.instance.client
          .from('users')
          .select('id')
          .eq('user_id', user.id)
          .single();

      final internalUserId = userData['id'] as int;

      // Get all scan dates for the user, ordered by most recent
      final result = await Supabase.instance.client
          .from('user_history')
          .select('created_at')
          .eq('user_id', internalUserId)
          .order('created_at', ascending: false);

      if (result.isEmpty) return 0;

      // Group scans by date
      Map<String, int> scansByDate = {};
      for (var record in result) {
        final createdAt = DateTime.parse(record['created_at']);
        final dateKey = '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
        scansByDate[dateKey] = (scansByDate[dateKey] ?? 0) + 1;
      }

      // Calculate streak
      final today = DateTime.now();
      int streak = 0;
      
      for (int i = 0; i < 365; i++) { // Check up to 365 days back
        final checkDate = today.subtract(Duration(days: i));
        final dateKey = '${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}';
        
        if (scansByDate.containsKey(dateKey)) {
          streak++;
        } else {
          break; // Streak broken
        }
      }

      return streak;
    } catch (e) {
      print('Error fetching streak: $e');
      return 0;
    }
  }

  /// Get user's PRO status
  /// For now, make everyone PRO for testing
  Future<bool> isProUser() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return false;

      // For now, make everyone PRO for testing
      return true;
      
      // TODO: Replace with actual PRO status check when ready
      // final result = await Supabase.instance.client
      //     .from('user_profiles')
      //     .select('is_pro')
      //     .eq('user_id', user.id)
      //     .single();
      // return result['is_pro'] == true;
    } catch (e) {
      print('Error checking PRO status: $e');
      return true; // Default to PRO for testing
    }
  }

  /// Get comprehensive user stats
  Future<Map<String, dynamic>> getUserStats() async {
    try {
      final scanCount = await getScanCount();
      final streak = await getCurrentStreak();
      final isPro = await isProUser();

      return {
        'scanCount': scanCount,
        'streak': streak,
        'isPro': isPro,
      };
    } catch (e) {
      print('Error fetching user stats: $e');
      return {
        'scanCount': 0,
        'streak': 0,
        'isPro': false,
      };
    }
  }
}
