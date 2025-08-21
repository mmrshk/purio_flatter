import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class IngredientsService {
  /// Parse ingredients from pre-parsed data in specifications
  static Future<List<MatchedIngredient>> parseAndMatchIngredients(Map<String, dynamic>? parsedIngredientsData) async {
    if (parsedIngredientsData == null) return [];

    List<dynamic> matches = parsedIngredientsData['matches'] ?? [];
    List<MatchedIngredient> matchedIngredients = [];
    
    for (Map<String, dynamic> match in matches) {
      String original = match['original'] ?? '';
      String matchedName = match['matched_name'] ?? '';
      String matchedIngredientId = match['matched_ingredient_id'] ?? '';
      int? novaScore = match['nova_score'];
      String englishName = match['english_name'] ?? '';
      String romanianName = match['romanian_name'] ?? '';
      
      // Fetch risk level from Supabase using matched_ingredient_id
      String? riskLevel;
      if (matchedIngredientId.isNotEmpty) {
        try {
          final ingredientData = await Supabase.instance.client
              .from('ingredients')
              .select('risk_level')
              .eq('id', matchedIngredientId)
              .single();
          
          riskLevel = ingredientData['risk_level'];
          print('🔍 Fetched risk_level for $matchedIngredientId: $riskLevel');
        } catch (e) {
          print('❌ Error fetching risk_level for $matchedIngredientId: $e');
          riskLevel = null;
        }
      }

      matchedIngredients.add(MatchedIngredient(
        originalName: capitalizeFirstLetter(original),
        dbIngredient: _createIngredientsRowFromMatch(
          id: matchedIngredientId,
          name: englishName,
          roName: romanianName,
          novaScore: novaScore,
          riskLevel: riskLevel,
        ),
        isMatched: true,
      ));
    }
    
    return matchedIngredients;
  }

  /// Create an IngredientsRow from pre-matched data
  static IngredientsRow _createIngredientsRowFromMatch({
    required String id,
    required String name,
    required String roName,
    required int? novaScore,
    String? riskLevel,
  }) {
    Map<String, dynamic> data = {
      'id': id,
      'created_at': DateTime.now().toIso8601String(),
      'name': name,
      'name_ro': roName,
      'nova_score': novaScore,
      'risk_level': riskLevel,
    };
    return IngredientsRow(data);
  }

  /// Get localized name for an ingredient
  static String getLocalizedName(MatchedIngredient ingredient, BuildContext context) {
    if (ingredient.isMatched && ingredient.dbIngredient != null) {
      final currentLanguage = FFLocalizations.of(context).languageCode;
      String name;
      if (currentLanguage == 'ro') {
        name = ingredient.dbIngredient!.roName;
      } else {
        name = ingredient.dbIngredient!.name;
      }
      return capitalizeFirstLetter(name);
    }
    return ingredient.originalName;
  }

  /// Get risk level color and text based on risk_level field
  static Map<String, dynamic> getRiskLevel(String? riskLevel) {
    switch (riskLevel?.toLowerCase()) {
      case 'free risk':
        return {'color': const Color(0xFF2ECC71), 'text': 'Free risk'};
      case 'low risk':
        return {'color': const Color(0xFF2ECC71), 'text': 'Low risk'};
      case 'moderate risk':
        return {'color': const Color(0xFFFFA500), 'text': 'Moderate risk'};
      case 'high risk':
        return {'color': const Color(0xFFE74C3C), 'text': 'High risk'};
      default:
        return {'color': const Color(0xFF6A7F98), 'text': 'Unknown'};
    }
  }

  /// Capitalize first letter of a string
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

/// Class to represent a matched ingredient
class MatchedIngredient {
  final String originalName;
  final IngredientsRow? dbIngredient;
  final bool isMatched;

  MatchedIngredient({
    required this.originalName,
    this.dbIngredient,
    required this.isMatched,
  });
}
