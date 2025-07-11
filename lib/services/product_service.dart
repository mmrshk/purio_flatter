import '/backend/supabase/supabase.dart';
import 'scoring_service.dart';
import 'dart:convert';

class ProductService {
  // Update health score for a single product
  static Future<Map<String, dynamic>?> updateHealthScore(ProductRow product) async {
    try {
      // Get nutritional data from specifications
      Map<String, dynamic> nutritional = {};
      Map<String, dynamic>? specs;
      try {
        final rawSpecs = product.data['specifications'];
        
        if (rawSpecs is Map<String, dynamic>) {
          specs = rawSpecs;
        } else if (rawSpecs is Map) {
          specs = Map<String, dynamic>.from(rawSpecs);
        } else if (rawSpecs is String) {
          try {
            final decoded = json.decode(rawSpecs);
            if (decoded is Map<String, dynamic>) {
              specs = decoded;
            } else if (decoded is Map) {
              specs = Map<String, dynamic>.from(decoded);
            }
          } catch (e) {
            // Error decoding specifications JSON
          }
        }
        
        final rawNutritional = specs?['nutritional'];
        
        if (rawNutritional != null) {
          if (rawNutritional is Map<String, dynamic>) {
            nutritional = rawNutritional;
          } else if (rawNutritional is Map) {
            nutritional = Map<String, dynamic>.from(rawNutritional);
          } else if (rawNutritional is String) {
            try {
              final decoded = json.decode(rawNutritional);
              if (decoded is Map<String, dynamic>) {
                nutritional = decoded;
              } else if (decoded is Map) {
                nutritional = Map<String, dynamic>.from(decoded);
              }
            } catch (e) {
              // Error decoding nutritional JSON
            }
          }
        }

        // Ensure all nutritional values are strings
        nutritional = nutritional.map((key, value) {
          if (value == null) return MapEntry(key, '0');
          return MapEntry(key, value.toString());
        });
      } catch (e) {
        // Error processing nutritional data
      }

      // Get ingredients from specifications
      String? ingredients;
      try {
        if (specs?.containsKey('ingredients') == true) {
          final rawIngredients = specs?['ingredients'];
          
          if (rawIngredients is String) {
            ingredients = rawIngredients;
          } else if (rawIngredients != null) {
            ingredients = rawIngredients.toString();
          }
        }
      } catch (e) {
        // Error processing ingredients
      }

      // Calculate health score
      int healthScore = 0;
      try {
        healthScore = ScoringService.calculateHealthScore(
          nutritional: nutritional,
          ingredients: ingredients,
        );
      } catch (e) {
        // Error calculating health score
      }

      // Update database
      final updateData = {'health_score': healthScore};
      
      // First, check if the product exists
      final existingProduct = await SupaFlow.client
          .from('Products')
          .select('id, health_score')
          .eq('id', product.id)
          .maybeSingle();
      
      if (existingProduct == null) {
        return null;
      }
      
      // Perform the update
      try {
        await SupaFlow.client
            .from('Products')
            .update(updateData)
            .eq('id', product.id);
        
        // Fetch the updated data
        final updatedData = await SupaFlow.client
            .from('Products')
            .select('id, health_score')
            .eq('id', product.id)
            .maybeSingle();
        
        return updatedData;
        
      } catch (updateError) {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
} 