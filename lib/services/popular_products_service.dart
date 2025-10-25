import '/backend/supabase/database/tables/product.dart';
import '/backend/supabase/supabase.dart';

class PopularProductsService {
  static PopularProductsService? _instance;
  static PopularProductsService get instance => _instance ??= PopularProductsService._();
  
  PopularProductsService._();

  /// Get popular products across the entire app based on user_history
  /// Returns the most scanned products globally
  Future<List<ProductRow>> getPopularProducts({int limit = 8}) async {
    try {
      // Query to get popular products across the entire app
      // Get all user history records to find most scanned products globally
      final historyResults = await Supabase.instance.client
          .from('user_history')
          .select('product_id');

      // Group by product_id and count occurrences across all users
      Map<String, int> productCounts = {};
      
      for (var record in historyResults) {
        final productId = record['product_id'] as String;
        productCounts[productId] = (productCounts[productId] ?? 0) + 1;
      }

      List<ProductRow> products = [];

      if (productCounts.isNotEmpty) {
        // Sort by count (descending) and take top products
        final sortedProducts = productCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        // Get product details for the most popular products
        for (var entry in sortedProducts.take(limit)) {
          try {
            final productResult = await Supabase.instance.client
                .from('products')
                .select()
                .eq('id', entry.key)
                .eq('visible', true)
                .single();
            
            products.add(ProductRow(productResult));
          } catch (e) {
            print('Error fetching product ${entry.key}: $e');
          }
        }
      }

      // If we have less than the requested limit, fill with recent products
      if (products.length < limit) {
        final recentResults = await Supabase.instance.client
            .from('products')
            .select()
            .eq('visible', true)
            .order('created_at', ascending: false)
            .limit(limit - products.length);
        
        final recentProducts = (recentResults as List)
            .map((e) => ProductRow(e as Map<String, dynamic>))
            .toList();
        
        products.addAll(recentProducts);
      }

      return products;
    } catch (e) {
      print('Error fetching popular products: $e');
      return [];
    }
  }

  /// Get user's personal popular products based on their scan history
  /// Returns the most scanned products for the current user
  Future<List<ProductRow>> getUserPopularProducts({int limit = 8}) async {
    try {
      // Get the current user ID
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        return [];
      }

      // Query to get popular products based on user_history for current user
      final historyResults = await Supabase.instance.client
          .from('user_history')
          .select('product_id')
          .eq('user_id', user.id);

      // Group by product_id and count occurrences
      Map<String, int> productCounts = {};
      
      for (var record in historyResults) {
        final productId = record['product_id'] as String;
        productCounts[productId] = (productCounts[productId] ?? 0) + 1;
      }

      List<ProductRow> products = [];

      if (productCounts.isNotEmpty) {
        // Sort by count (descending) and take top products
        final sortedProducts = productCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        // Get product details for the most popular products
        for (var entry in sortedProducts.take(limit)) {
          try {
            final productResult = await Supabase.instance.client
                .from('products')
                .select()
                .eq('id', entry.key)
                .eq('visible', true)
                .single();
            
            products.add(ProductRow(productResult));
          } catch (e) {
            print('Error fetching product ${entry.key}: $e');
          }
        }
      }

      // If we have less than the requested limit, fill with recent products
      if (products.length < limit) {
        final recentResults = await Supabase.instance.client
            .from('products')
            .select()
            .eq('visible', true)
            .order('created_at', ascending: false)
            .limit(limit - products.length);
        
        final recentProducts = (recentResults as List)
            .map((e) => ProductRow(e as Map<String, dynamic>))
            .toList();
        
        products.addAll(recentProducts);
      }

      return products;
    } catch (e) {
      print('Error fetching user popular products: $e');
      return [];
    }
  }
}
