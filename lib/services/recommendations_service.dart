import '/backend/supabase/supabase.dart';

class RecommendationsService {
  /// Get the best rated product in the same category
  static Future<ProductRow?> getBestRatedProductInCategory(String category, String excludeProductId) async {
    try {
      // Query products in the same category, excluding the current product
      // Order by health score (final_score) descending to get the best rated
      final products = await ProductTable().queryRows(
        queryFn: (q) => q
            .eq('category', category)
            .neq('id', excludeProductId)
            .not('final_score', 'is', null) // Only products with a health score
            .order('final_score', ascending: false)
            .limit(1),
      );
      
      if (products.isNotEmpty) {
        return products.first;
      }
      
      return null;
    } catch (e) {
      print('Error fetching recommended product: $e');
      return null;
    }
  }

  /// Get multiple recommended products in the same category
  static Future<List<ProductRow>> getRecommendedProductsInCategory(String category, String excludeProductId, {int limit = 3}) async {
    try {
      // Query products in the same category, excluding the current product
      // Order by health score (final_score) descending to get the best rated
      final products = await ProductTable().queryRows(
        queryFn: (q) => q
            .eq('category', category)
            .neq('id', excludeProductId)
            .not('final_score', 'is', null) // Only products with a health score
            .order('final_score', ascending: false)
            .limit(limit),
      );
      
      return products;
    } catch (e) {
      print('Error fetching recommended products: $e');
      return [];
    }
  }

  /// Get recommended products across all categories (fallback)
  static Future<List<ProductRow>> getGeneralRecommendedProducts(String excludeProductId, {int limit = 3}) async {
    try {
      // Query products across all categories, excluding the current product
      // Order by health score (final_score) descending to get the best rated
      final products = await ProductTable().queryRows(
        queryFn: (q) => q
            .neq('id', excludeProductId)
            .not('final_score', 'is', null) // Only products with a health score
            .order('final_score', ascending: false)
            .limit(limit),
      );
      
      return products;
    } catch (e) {
      print('Error fetching general recommended products: $e');
      return [];
    }
  }

  /// Get products with same or higher health score for recommendations page
  static Future<List<ProductRow>> getProductsWithSameOrHigherScore(int healthScore, String excludeProductId, String category, {int limit = 10}) async {
    try {
      // Query products with same or higher health score in the same category, excluding the current product
      // Order by health score (final_score) descending
      final products = await ProductTable().queryRows(
        queryFn: (q) => q
            .eq('category', category) // Same category
            .neq('id', excludeProductId)
            .not('final_score', 'is', null) // Only products with a health score
            .gte('final_score', healthScore) // Same or higher health score
            .order('final_score', ascending: false)
            .limit(limit),
      );
      
      return products;
    } catch (e) {
      print('Error fetching products with same or higher score: $e');
      return [];
    }
  }

  /// Get products with score bigger than 50 when current product has no scoring
  static Future<List<ProductRow>> getProductsWithScoreBiggerThan50(String excludeProductId, String category, {int limit = 10}) async {
    try {
      // Query products with health score bigger than 50 in the same category, excluding the current product
      final products = await ProductTable().queryRows(
        queryFn: (q) => q
            .eq('category', category) // Same category
            .neq('id', excludeProductId)
            .not('final_score', 'is', null) // Only products with a health score
            .gt('final_score', 50) // Score bigger than 50
            .order('final_score', ascending: false)
            .limit(limit),
      );
      
      return products;
    } catch (e) {
      print('Error fetching products with score bigger than 50: $e');
      return [];
    }
  }
}
