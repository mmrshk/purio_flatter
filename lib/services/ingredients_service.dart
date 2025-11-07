import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientsService {
  /// Parse ingredients from pre-parsed data in specifications
  static Future<List<MatchedIngredient>> parseAndMatchIngredients(Map<String, dynamic>? parsedIngredientsData) async {
    if (parsedIngredientsData == null) return [];

    List<dynamic> matches = parsedIngredientsData['matches'] ?? [];
    List<MatchedIngredient> matchedIngredients = [];
    Set<String> processedIds = {}; // Track processed ingredient IDs to avoid duplicates
    
    for (Map<String, dynamic> match in matches) {
      String original = match['original'] ?? '';
      
      // Extract data from match structure - support both old and new formats
      Map<String, dynamic>? matchData = match['data'];
      String matchedIngredientId = '';
      int? novaScore;
      String englishName = '';
      String romanianName = '';
      
      if (matchData != null) {
        // New format: data is nested in 'data' object
        matchedIngredientId = matchData['id']?.toString() ?? '';
        novaScore = matchData['nova_score'];
        englishName = matchData['name'] ?? '';
        romanianName = matchData['ro_name'] ?? '';
      } else {
        // Old format: data is directly in match object (backward compatibility)
        matchedIngredientId = match['matched_ingredient_id']?.toString() ?? '';
        novaScore = match['nova_score'];
        englishName = match['english_name'] ?? '';
        romanianName = match['romanian_name'] ?? '';
      }
      
      // Skip if we've already processed this ingredient ID
      if (matchedIngredientId.isNotEmpty && processedIds.contains(matchedIngredientId)) {
        continue;
      }
      
      // Fetch ingredient details from Supabase using matched_ingredient_id
      String? riskLevel;
      String? description;
      String? roDescription;
      if (matchedIngredientId.isNotEmpty) {
        try {
          final ingredientData = await Supabase.instance.client
              .from('ingredients')
              .select('risk_level, description, ro_description')
              .eq('id', matchedIngredientId)
              .eq('visible', true)
              .single();
          
          riskLevel = ingredientData['risk_level'];
          description = ingredientData['description'];
          roDescription = ingredientData['ro_description'];
          print('🔍 Fetched ingredient data for $matchedIngredientId: risk=$riskLevel, desc=$description');
          
          // Mark this ID as processed
          processedIds.add(matchedIngredientId);
        } catch (e) {
          print('❌ Error fetching ingredient data for $matchedIngredientId: $e');
          riskLevel = null;
          description = null;
          roDescription = null;
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
          description: description,
          roDescription: roDescription,
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
    String? description,
    String? roDescription,
  }) {
    Map<String, dynamic> data = {
      'id': id,
      'created_at': DateTime.now().toIso8601String(),
      'name': name,
      'ro_name': roName,
      'nova_score': novaScore,
      'risk_level': riskLevel,
      'description': description,
      'ro_description': roDescription,
    };
    return IngredientsRow(data);
  }

  /// Get localized name for an ingredient
  static String getLocalizedName(MatchedIngredient ingredient, BuildContext context) {
    if (ingredient.isMatched && ingredient.dbIngredient != null) {
      final currentLanguage = FFLocalizations.of(context).languageCode;
      String name;
      if (currentLanguage == 'ro') {
        name = ingredient.dbIngredient!.roName ?? ingredient.originalName;
      } else {
        name = ingredient.dbIngredient!.name ?? ingredient.originalName;
      }
      // If the dbIngredient name is empty, fall back to originalName
      if (name.isEmpty) {
        return ingredient.originalName;
      }
      return capitalizeFirstLetter(name);
    }
    return ingredient.originalName;
  }

  /// Get risk level color and text based on risk_level field
  static Map<String, dynamic> getRiskLevel(String? riskLevel) {
    switch (riskLevel?.toLowerCase()) {
      case 'free':
        return {'color': const Color(0xFF2ECC71), 'text': 'Free risk'};
      case 'low':
        return {'color': const Color(0xFF2ECC71), 'text': 'Low risk'};
      case 'moderate':
        return {'color': const Color(0xFFFFA500), 'text': 'Moderate risk'};
      case 'high':
        return {'color': const Color(0xFFE74C3C), 'text': 'High risk'};
      default:
        print('🔍 Unknown risk level: $riskLevel');
        return {'color': const Color(0xFF6A7F98), 'text': 'Unknown'};
    }
  }

  /// Get the appropriate description based on current language
  static String getLocalizedDescription(MatchedIngredient ingredient, BuildContext context) {
    if (ingredient.dbIngredient == null) {
      return ingredient.originalName;
    }
    
    final currentLanguage = FFLocalizations.of(context).languageCode;
    
    if (currentLanguage == 'ro' && ingredient.dbIngredient!.roDescription != null && ingredient.dbIngredient!.roDescription!.isNotEmpty) {
      return ingredient.dbIngredient!.roDescription!;
    }
    
    return ingredient.dbIngredient!.description ?? ingredient.originalName;
  }

  /// Show ingredient information dialog
  static void showIngredientInfoDialog(MatchedIngredient ingredient, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  getLocalizedName(ingredient, context),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                ),
              ),
              if (ingredient.dbIngredient?.riskLevel != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: getRiskLevel(ingredient.dbIngredient!.riskLevel)['color'],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    getRiskLevel(ingredient.dbIngredient!.riskLevel)['text'],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                  ),
                ),
              ],
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description:',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                getLocalizedDescription(ingredient, context),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.normal),
                      color: const Color(0xFF6A7F98),
                      fontSize: 14.0,
                    ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      color: const Color(0xFF40A5A5),
                      fontSize: 16.0,
                    ),
              ),
            ),
          ],
        );
      },
    );
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
