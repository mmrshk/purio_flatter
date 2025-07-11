import 'dart:math';
import 'dart:convert';

class ScoringService {
  // Constants for scoring weights
  static const double NUTRISCORE_WEIGHT = 0.4;
  static const double ADDITIVES_WEIGHT = 0.3;
  static const double NOVA_WEIGHT = 0.3;

  // Constants for NOVA score mapping
  static const Map<int, int> NOVA_SCORES = {
    1: 100, // Unprocessed or minimally processed foods
    2: 80,  // Processed culinary ingredients
    3: 60,  // Processed foods
    4: 30,  // Ultra-processed foods
  };

  // Helper function to safely parse numeric values
  static double _parseNumericValue(dynamic value) {
    print('\nParsing numeric value:');
    print('Input value: $value');
    print('Input type: ${value.runtimeType}');
    
    if (value == null) {
      print('Value is null, returning 0.0');
      return 0.0;
    }
    if (value is num) {
      print('Value is num, converting to double: ${value.toDouble()}');
      return value.toDouble();
    }
    if (value is String) {
      print('Value is String, cleaning and parsing');
      // Remove any non-numeric characters except decimal point
      String cleanValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
      print('Cleaned value: $cleanValue');
      if (cleanValue.isEmpty) {
        print('Cleaned value is empty, returning 0.0');
        return 0.0;
      }
      double result = double.tryParse(cleanValue) ?? 0.0;
      print('Parsed result: $result');
      return result;
    }
    print('Value is neither num nor String, returning 0.0');
    return 0.0;
  }

  // Calculate NutriScore based on nutritional values
  static int calculateNutriScore(Map<String, dynamic> nutritional) {
    if (nutritional == null || nutritional.isEmpty) {
      print('Nutritional data is null or empty, returning 0');
      return 0;
    }

    try {
      print('\n=== Calculating NutriScore ===');
      print('Input nutritional data: $nutritional');
      
      // Get the actual nutritional values map
      Map<String, dynamic> values = nutritional;
      if (nutritional.containsKey('nutritional')) {
        print('Found nested nutritional data');
        final rawNutritional = nutritional['nutritional'];
        print('Raw nutritional type: ${rawNutritional.runtimeType}');
        print('Raw nutritional value: $rawNutritional');
        
        if (rawNutritional is Map<String, dynamic>) {
          values = rawNutritional;
          print('Using Map<String, dynamic> nutritional data');
        } else if (rawNutritional is Map) {
          values = Map<String, dynamic>.from(rawNutritional);
          print('Converted Map to Map<String, dynamic>');
        } else if (rawNutritional is String) {
          print('Attempting to decode JSON string');
          try {
            final decoded = json.decode(rawNutritional);
            print('Decoded JSON type: ${decoded.runtimeType}');
            if (decoded is Map<String, dynamic>) {
              values = decoded;
              print('Using decoded Map<String, dynamic>');
            } else if (decoded is Map) {
              values = Map<String, dynamic>.from(decoded);
              print('Converted decoded Map to Map<String, dynamic>');
            }
          } catch (e) {
            print('Error decoding nutritional JSON: $e');
            return 0;
          }
        }
      }
      
      print('\nUsing nutritional values:');
      values.forEach((key, value) {
        print('$key: ${value.runtimeType} = $value');
      });
      
      // Convert energy from kcal to kJ if needed
      double energy = _parseNumericValue(values['calories_per_100g_or_100ml']);
      print('\nEnergy value: $energy');
      double energyKj = energy * 4.184; // Convert kcal to kJ
      print('Energy in kJ: $energyKj');

      // Get other nutritional values
      double sugar = _parseNumericValue(values['sugar']);
      print('Sugar value: $sugar');
      double saturatedFat = _parseNumericValue(values['saturated_fat']);
      print('Saturated fat value: $saturatedFat');
      double sodium = _parseNumericValue(values['salt']);
      print('Sodium value: $sodium');
      double protein = _parseNumericValue(values['protein']);
      print('Protein value: $protein');
      double fiber = _parseNumericValue(values['fiber']);
      print('Fiber value: $fiber');

      // Calculate points based on NutriScore algorithm
      int points = 0;
      print('\nCalculating points:');

      // Energy points (0-10)
      if (energyKj <= 335) points += 0;
      else if (energyKj <= 670) points += 1;
      else if (energyKj <= 1005) points += 2;
      else if (energyKj <= 1340) points += 3;
      else if (energyKj <= 1675) points += 4;
      else if (energyKj <= 2010) points += 5;
      else if (energyKj <= 2345) points += 6;
      else if (energyKj <= 2680) points += 7;
      else if (energyKj <= 3015) points += 8;
      else if (energyKj <= 3350) points += 9;
      else points += 10;
      print('Energy points: $points');

      // Sugar points (0-10)
      int sugarPoints = 0;
      if (sugar <= 4.5) sugarPoints = 0;
      else if (sugar <= 9) sugarPoints = 1;
      else if (sugar <= 13.5) sugarPoints = 2;
      else if (sugar <= 18) sugarPoints = 3;
      else if (sugar <= 22.5) sugarPoints = 4;
      else if (sugar <= 27) sugarPoints = 5;
      else if (sugar <= 31) sugarPoints = 6;
      else if (sugar <= 36) sugarPoints = 7;
      else if (sugar <= 40) sugarPoints = 8;
      else if (sugar <= 45) sugarPoints = 9;
      else sugarPoints = 10;
      points += sugarPoints;
      print('Sugar points: $sugarPoints, Total points: $points');

      // Saturated fat points (0-10)
      int fatPoints = 0;
      if (saturatedFat <= 1) fatPoints = 0;
      else if (saturatedFat <= 2) fatPoints = 1;
      else if (saturatedFat <= 3) fatPoints = 2;
      else if (saturatedFat <= 4) fatPoints = 3;
      else if (saturatedFat <= 5) fatPoints = 4;
      else if (saturatedFat <= 6) fatPoints = 5;
      else if (saturatedFat <= 7) fatPoints = 6;
      else if (saturatedFat <= 8) fatPoints = 7;
      else if (saturatedFat <= 9) fatPoints = 8;
      else if (saturatedFat <= 10) fatPoints = 9;
      else fatPoints = 10;
      points += fatPoints;
      print('Fat points: $fatPoints, Total points: $points');

      // Sodium points (0-10)
      int sodiumPoints = 0;
      if (sodium <= 0.09) sodiumPoints = 0;
      else if (sodium <= 0.18) sodiumPoints = 1;
      else if (sodium <= 0.27) sodiumPoints = 2;
      else if (sodium <= 0.36) sodiumPoints = 3;
      else if (sodium <= 0.45) sodiumPoints = 4;
      else if (sodium <= 0.54) sodiumPoints = 5;
      else if (sodium <= 0.63) sodiumPoints = 6;
      else if (sodium <= 0.72) sodiumPoints = 7;
      else if (sodium <= 0.81) sodiumPoints = 8;
      else if (sodium <= 0.9) sodiumPoints = 9;
      else sodiumPoints = 10;
      points += sodiumPoints;
      print('Sodium points: $sodiumPoints, Total points: $points');

      // Protein points (0-5)
      int proteinPoints = 0;
      if (protein >= 8) proteinPoints = -5;
      else if (protein >= 6.4) proteinPoints = -4;
      else if (protein >= 4.8) proteinPoints = -3;
      else if (protein >= 3.2) proteinPoints = -2;
      else if (protein >= 1.6) proteinPoints = -1;
      points += proteinPoints;
      print('Protein points: $proteinPoints, Total points: $points');

      // Fiber points (0-5)
      int fiberPoints = 0;
      if (fiber >= 4.7) fiberPoints = -5;
      else if (fiber >= 3.7) fiberPoints = -4;
      else if (fiber >= 2.8) fiberPoints = -3;
      else if (fiber >= 1.9) fiberPoints = -2;
      else if (fiber >= 0.9) fiberPoints = -1;
      points += fiberPoints;
      print('Fiber points: $fiberPoints, Total points: $points');

      // Convert points to NutriScore (A-E)
      int score;
      if (points <= 1) score = 100; // A
      else if (points <= 2) score = 80; // B
      else if (points <= 5) score = 60; // C
      else if (points <= 9) score = 40; // D
      else score = 20; // E
      print('\nFinal NutriScore: $score (points: $points)');
      return score;
    } catch (e) {
      print('Error calculating NutriScore: $e');
      print('Error stack trace: ${StackTrace.current}');
      return 0;
    }
  }

  // Calculate Additives Score
  static int calculateAdditivesScore(String? ingredients) {
    if (ingredients == null || ingredients.isEmpty) return 100;

    // Check for E-numbers in ingredients
    final eNumberPattern = RegExp(r'E\d{3}[a-z]?');
    final matches = eNumberPattern.allMatches(ingredients);
    
    // If no additives found, return perfect score
    if (matches.isEmpty) return 100;

    // Calculate score based on number of additives
    int additiveCount = matches.length;
    if (additiveCount == 0) return 100;
    else if (additiveCount <= 2) return 80;
    else if (additiveCount <= 4) return 60;
    else if (additiveCount <= 6) return 40;
    else return 20;
  }

  // Calculate NOVA Score
  static int calculateNovaScore(String? ingredients) {
    if (ingredients == null || ingredients.isEmpty) return 80; // Default to NOVA 2

    // Simple heuristic for NOVA classification
    final ultraProcessedPatterns = [
      'modified starch',
      'hydrogenated',
      'high fructose',
      'corn syrup',
      'maltodextrin',
      'carrageenan',
      'xanthan gum',
      'guar gum',
      'aspartame',
      'acesulfame',
      'sucralose',
      'saccharin',
      'sodium nitrite',
      'sodium nitrate',
      'BHA',
      'BHT',
      'TBHQ',
      'propylene glycol',
      'polysorbate',
      'monoglycerides',
      'diglycerides',
      'lecithin',
      'carrageenan',
      'xanthan gum',
      'guar gum',
      'cellulose gum',
      'modified cellulose',
      'modified corn starch',
      'modified tapioca starch',
      'modified potato starch',
      'modified wheat starch',
      'modified rice starch',
      'modified pea starch',
      'modified soy protein',
      'modified whey protein',
      'modified milk protein',
      'modified egg protein',
      'modified wheat protein',
      'modified corn protein',
      'modified soy protein',
      'modified pea protein',
      'modified rice protein',
      'modified potato protein',
      'modified tapioca protein',
      'modified wheat protein',
      'modified corn protein',
      'modified soy protein',
      'modified pea protein',
      'modified rice protein',
      'modified potato protein',
      'modified tapioca protein',
    ];

    // Check for ultra-processed ingredients
    for (var pattern in ultraProcessedPatterns) {
      if (ingredients.toLowerCase().contains(pattern.toLowerCase())) {
        return NOVA_SCORES[4]!; // Ultra-processed
      }
    }

    // Check for basic ingredients that suggest minimal processing
    final basicIngredients = [
      'water',
      'salt',
      'sugar',
      'milk',
      'cream',
      'butter',
      'oil',
      'flour',
      'egg',
      'honey',
      'fruit',
      'vegetable',
      'meat',
      'fish',
      'poultry',
      'grain',
      'legume',
      'nut',
      'seed',
      'herb',
      'spice',
    ];

    bool hasOnlyBasicIngredients = true;
    for (var ingredient in ingredients.split(',')) {
      ingredient = ingredient.trim().toLowerCase();
      bool isBasic = false;
      for (var basic in basicIngredients) {
        if (ingredient.contains(basic)) {
          isBasic = true;
          break;
        }
      }
      if (!isBasic) {
        hasOnlyBasicIngredients = false;
        break;
      }
    }

    if (hasOnlyBasicIngredients) {
      return NOVA_SCORES[1]!; // Unprocessed or minimally processed
    }

    return NOVA_SCORES[2]!; // Default to processed
  }

  static int calculateHealthScore({
    required Map<String, dynamic> nutritional,
    required String? ingredients,
  }) {
    int nutriScore = calculateNutriScore(nutritional);
    int additivesScore = calculateAdditivesScore(ingredients);
    int novaScore = calculateNovaScore(ingredients);

    double finalScore = (nutriScore * NUTRISCORE_WEIGHT) +
        (additivesScore * ADDITIVES_WEIGHT) +
        (novaScore * NOVA_WEIGHT);

    return finalScore.round();
  }
} 