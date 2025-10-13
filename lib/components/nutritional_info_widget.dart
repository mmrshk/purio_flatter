import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NutritionalInfoWidget extends StatelessWidget {
  const NutritionalInfoWidget({
    super.key,
    required this.nutritionalData,
  });

  final Map<String, dynamic>? nutritionalData;

  @override
  Widget build(BuildContext context) {
    if (nutritionalData == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: _buildNutritionalGrid(context),
    );
  }

  Widget _buildNutritionalGrid(BuildContext context) {
    final items = <Widget>[];
    
    // Add nutritional items if they exist - using the actual field names from specifications
    if (nutritionalData!['fat'] != null) {
      items.add(_buildNutritionItem(context, 'Fat', '${nutritionalData!['fat']}g', Icons.opacity, const Color(0xFFE57373)));
    }
    
    if (nutritionalData!['saturated_fat'] != null) {
      items.add(_buildNutritionItem(context, 'Saturated Fat', '${nutritionalData!['saturated_fat']}g', Icons.opacity, const Color(0xFFE57373)));
    }
    
    if (nutritionalData!['sugar'] != null) {
      items.add(_buildNutritionItem(context, 'Sugar', '${nutritionalData!['sugar']}g', Icons.cake, const Color(0xFFF06292)));
    }
    
    if (nutritionalData!['protein'] != null) {
      items.add(_buildNutritionItem(context, 'Protein', '${nutritionalData!['protein']}g', Icons.fitness_center, const Color(0xFF81C784)));
    }
    
    if (nutritionalData!['carbohydrates'] != null) {
      items.add(_buildNutritionItem(context, 'Carbs', '${nutritionalData!['carbohydrates']}g', Icons.grain, const Color(0xFFFFB74D)));
    }
    
    if (nutritionalData!['fiber'] != null) {
      items.add(_buildNutritionItem(context, 'Fiber', '${nutritionalData!['fiber']}g', Icons.grain, const Color(0xFF9C27B0)));
    }
    
    if (nutritionalData!['salt'] != null) {
      items.add(_buildNutritionItem(context, 'Salt', '${nutritionalData!['salt']}g', Icons.grain, const Color(0xFF607D8B)));
    }
    
    if (nutritionalData!['calories_per_100g_or_100ml'] != null) {
      items.add(_buildNutritionItem(context, 'Calories', '${nutritionalData!['calories_per_100g_or_100ml']} kcal', Icons.local_fire_department, const Color(0xFFFF8A65)));
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: items,
    );
  }

  Widget _buildNutritionItem(BuildContext context, String label, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 12.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              '$label: $value',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: color,
                    fontSize: 11.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
