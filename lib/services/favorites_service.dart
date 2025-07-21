import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';

class FavoritesService {
  /// Add a product to user's favorites
  static Future<void> addToFavorites(String productId) async {
    try {
      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        // Check if this product is already in user's favorites
        final existingFavorite = await UserFavoritesTable().queryRows(
          queryFn: (q) => q
              .eq('user_id', userId)
              .eq('product_id', productId),
        );

        // If not already in favorites, add it
        if (existingFavorite.isEmpty) {
          await UserFavoritesTable().insert({
            'product_id': productId,
            'user_id': userId,
          });
          print('Added product $productId to user favorites');
        } else {
          print('Product $productId already in user favorites');
        }
      } else {
        print('User data not found for favorites tracking');
      }
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  /// Remove a product from user's favorites
  static Future<void> removeFromFavorites(String productId) async {
    try {
      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        // Remove the product from favorites
        await UserFavoritesTable().delete(
          matchingRows: (q) => q
              .eq('user_id', userId)
              .eq('product_id', productId),
        );
        
        print('Removed product $productId from user favorites');
      } else {
        print('User data not found for favorites tracking');
      }
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }

  /// Check if a product is in user's favorites
  static Future<bool> isFavorite(String productId) async {
    try {
      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        // Check if this product is in user's favorites
        final existingFavorite = await UserFavoritesTable().queryRows(
          queryFn: (q) => q
              .eq('user_id', userId)
              .eq('product_id', productId),
        );

        return existingFavorite.isNotEmpty;
      }
      
      return false;
    } catch (e) {
      print('Error checking if product is favorite: $e');
      return false;
    }
  }

  /// Get user's favorites with product details
  static Future<List<ProductRow>> getUserFavorites({int limit = 10}) async {
    try {
      // Get the current user's ID from the users table
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        // Get user's favorites with product details
        final favorites = await SupaFlow.client
            .from('user_favorites')
            .select('''
              product_id,
              created_at,
              products!inner(*)
            ''')
            .eq('user_id', userId)
            .order('created_at', ascending: false)
            .limit(limit);

        // Convert to ProductRow objects
        final products = favorites.map((item) {
          final productData = item['products'] as Map<String, dynamic>;
          return ProductRow(productData);
        }).toList();

        return products;
      }
      
      return [];
    } catch (e) {
      print('Error getting user favorites: $e');
      return [];
    }
  }

  /// Clear user's favorites
  static Future<void> clearFavorites() async {
    try {
      final userData = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', currentUserUid),
      );

      if (userData.isNotEmpty) {
        final userId = userData.first.id;
        
        await UserFavoritesTable().delete(
          matchingRows: (q) => q.eq('user_id', userId),
        );
        
        print('Cleared user favorites');
      }
    } catch (e) {
      print('Error clearing favorites: $e');
    }
  }
} 