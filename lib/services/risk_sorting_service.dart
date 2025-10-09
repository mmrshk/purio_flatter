import '/backend/supabase/supabase.dart';

class RiskSortingService {
  // Define risk level priority (high to low)
  // Support both formats: "High risk" and "high"
  static const Map<String, int> riskLevels = {
    'High risk': 1,
    'high': 1,
    'Moderate risk': 2,
    'moderate': 2,
    'Low risk': 3,
    'low': 3,
    'Free risk': 4,
    'free': 4,
  };

  /// Sorts additives by risk level from high to low
  static List<AdditivesRow> sortAdditivesByRisk(List<AdditivesRow> additives) {
    final sortedList = List<AdditivesRow>.from(additives);
    sortedList.sort((a, b) {
      final aRisk = a.riskLevel ?? 'unknown';
      final bRisk = b.riskLevel ?? 'unknown';
      
      final aPriority = riskLevels[aRisk] ?? 999;
      final bPriority = riskLevels[bRisk] ?? 999;
      
      // Sort by risk level first (high to low)
      if (aPriority != bPriority) {
        return aPriority.compareTo(bPriority);
      }
      
      // If risk levels are the same, sort by code
      return a.code.compareTo(b.code);
    });
    
    // Debug: Print first few additives to verify sorting
    if (sortedList.isNotEmpty) {
      print('Additives sorted by risk (first 5):');
      for (int i = 0; i < (sortedList.length > 5 ? 5 : sortedList.length); i++) {
        final additive = sortedList[i];
        print('${i + 1}. ${additive.code} - ${additive.riskLevel ?? 'unknown'}');
      }
    }
    
    return sortedList;
  }

  /// Sorts ingredients by risk level from high to low
  static List<IngredientsRow> sortIngredientsByRisk(List<IngredientsRow> ingredients) {
    final sortedList = List<IngredientsRow>.from(ingredients);
    sortedList.sort((a, b) {
      final aRisk = a.riskLevel ?? 'unknown';
      final bRisk = b.riskLevel ?? 'unknown';
      
      final aPriority = riskLevels[aRisk] ?? 999;
      final bPriority = riskLevels[bRisk] ?? 999;
      
      // Sort by risk level first (high to low)
      if (aPriority != bPriority) {
        return aPriority.compareTo(bPriority);
      }
      
      // If risk levels are the same, sort by name
      return a.name.compareTo(b.name);
    });
    
    // Debug: Print first few ingredients to verify sorting
    if (sortedList.isNotEmpty) {
      print('Ingredients sorted by risk (first 5):');
      for (int i = 0; i < (sortedList.length > 5 ? 5 : sortedList.length); i++) {
        final ingredient = sortedList[i];
        print('${i + 1}. ${ingredient.name} - ${ingredient.riskLevel ?? 'unknown'}');
      }
    }
    
    return sortedList;
  }

  /// Gets the priority number for a given risk level
  static int getRiskPriority(String? riskLevel) {
    return riskLevels[riskLevel ?? 'unknown'] ?? 999;
  }

  /// Checks if a risk level is considered high risk
  static bool isHighRisk(String? riskLevel) {
    return riskLevel == 'High risk';
  }

  /// Checks if a risk level is considered safe
  static bool isSafe(String? riskLevel) {
    return riskLevel == 'Free risk' || riskLevel == 'free';
  }

  /// Gets risk score for sorting (higher score = higher risk)
  /// This method is compatible with the additives_ingredients_section_widget
  static int getRiskScore(String? riskLevel) {
    return riskLevels[riskLevel ?? 'unknown'] ?? 999;
  }
}
