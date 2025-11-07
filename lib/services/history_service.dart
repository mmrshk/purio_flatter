import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';

class HistoryService {
  /// Add a product to user's history when they view it
  static Future<void> addToHistory(String productId) async {
    try {
      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        // Check if this product is already in user's history
        final existingHistory = await UserHistoryTable().queryRows(
          queryFn: (q) => q
              .eq('user_id', userId)
              .eq('product_id', productId),
        );

        // If not already in history, add it
        if (existingHistory.isEmpty) {
          await UserHistoryTable().insert({
            'product_id': productId,
            'user_id': userId,
          });
          print('Added product $productId to user history');
        } else {
          print('Product $productId already in user history');
        }
      } else {
        print('User data not found for history tracking');
      }
    } catch (e) {
      print('Error adding to history: $e');
    }
  }

  /// Get user's history with product details
  static Future<List<ProductRow>> getUserHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        // Get user's history with product details
        final history = await SupaFlow.client
            .from('user_history')
            .select('''
              product_id,
              created_at,
              products!inner(*)
            ''')
            .eq('user_id', userId)
            .order('created_at', ascending: false)
            .range(offset, offset + limit - 1);

        // Convert to ProductRow objects
        final products = history.map((item) {
          final productData = item['products'] as Map<String, dynamic>;
          return ProductRow(productData);
        }).toList();

        return products;
      }
      
      return [];
    } catch (e) {
      print('Error getting user history: $e');
      return [];
    }
  }

  /// Clear user's history
  static Future<void> clearHistory() async {
    try {
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        await UserHistoryTable().delete(
          matchingRows: (q) => q.eq('user_id', userId),
        );
        
        print('Cleared user history');
      }
    } catch (e) {
      print('Error clearing history: $e');
    }
  }
} 