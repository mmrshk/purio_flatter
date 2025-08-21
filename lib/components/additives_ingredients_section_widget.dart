import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
import '/backend/supabase/supabase.dart';
import '/services/additives_service.dart';
import '/services/ingredients_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditivesIngredientsSectionWidget extends StatefulWidget {
  const AdditivesIngredientsSectionWidget({
    Key? key,
    required this.additives,
    required this.ingredients,
    required this.visibleIngredientsCount,
    required this.hasMoreIngredients,
    required this.onShowMore,
    required this.onAdditiveTap,
    required this.onSeeAll,
    this.isLoadingIngredients = false,
    this.rawIngredientsText,
  }) : super(key: key);

  final List<AdditivesRow> additives;
  final List<MatchedIngredient> ingredients;
  final int visibleIngredientsCount;
  final bool hasMoreIngredients;
  final VoidCallback onShowMore;
  final Function(AdditivesRow) onAdditiveTap;
  final VoidCallback onSeeAll;
  final bool isLoadingIngredients;
  final String? rawIngredientsText;

  @override
  State<AdditivesIngredientsSectionWidget> createState() => _AdditivesIngredientsSectionWidgetState();
}

class _AdditivesIngredientsSectionWidgetState extends State<AdditivesIngredientsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Combined Section Header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 17.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  FFLocalizations.of(context).getText('9bs48st0' /* Ingredients */),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Colors.black,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              if (widget.additives.length + widget.ingredients.length > 5)
                InkWell(
                  onTap: widget.onSeeAll,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      FFLocalizations.of(context).getText('6mn4fkqn' /* See All */),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: const Color(0xFF40A5A5),
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        // Combined Ingredients List (Additives + Ingredients)
        if (widget.isLoadingIngredients)
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 23.0),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Color(0xFF40A5A5),
              ),
            ),
          )
        else if (widget.additives.isEmpty && widget.ingredients.isEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 23.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    '- ${FFLocalizations.of(context).getText('no_ingredients')}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                          color: const Color(0xFF2ECC71),
                          fontSize: 15.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ],
            ),
          )
                            else
            ..._buildCombinedIngredientsList(),
        
        // Show More Button for Combined Ingredients
        if (_shouldShowMoreButton())
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 29.0),
              child: InkWell(
                onTap: widget.onShowMore,
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  width: double.infinity,
                  height: 31.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF40E0D0),
                        Color(0xFFA8F0E4)
                      ],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(1.0, 0.0),
                      end: AlignmentDirectional(-1.0, 0),
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_getRemainingCount()} more ingredients',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              color: Colors.white,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildCombinedIngredientsList() {
    List<Widget> widgets = [];
    int totalItems = 0;
    const int maxItems = 5;

    // Create combined list of all items with their risk levels
    List<Map<String, dynamic>> allItems = [];
    
    // Add additives with their risk levels
    for (int i = 0; i < widget.additives.length; i++) {
      allItems.add({
        'type': 'additive',
        'index': i,
        'riskLevel': widget.additives[i].riskLevel ?? 'Unknown',
        'riskScore': _getRiskScore(widget.additives[i].riskLevel),
      });
    }
    
    // Add ingredients with their risk levels
    for (int i = 0; i < widget.ingredients.length; i++) {
      allItems.add({
        'type': 'ingredient',
        'index': i,
        'riskLevel': widget.ingredients[i].dbIngredient?.riskLevel ?? 'Unknown',
        'riskScore': _getRiskScore(widget.ingredients[i].dbIngredient?.riskLevel),
      });
    }
    
    // Sort by risk score (high to low)
    allItems.sort((a, b) => b['riskScore'].compareTo(a['riskScore']));
    
    // Build widgets from sorted list
    for (int i = 0; i < allItems.length && totalItems < maxItems; i++) {
      var item = allItems[i];
      
      if (item['type'] == 'additive') {
        int additiveIndex = item['index'];
        widgets.add(
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
            child: InkWell(
              onTap: () => widget.onAdditiveTap(widget.additives[additiveIndex]),
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.additives[additiveIndex].code} - ',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                ),
                          ),
                          Text(
                            getLocalizedText(
                              context,
                              widget.additives[additiveIndex].name,
                              widget.additives[additiveIndex].roName,
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                ),
                          ),
                          if (widget.additives[additiveIndex].riskLevel != null) ...[
                            const SizedBox(width: 8.0),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: AdditivesService.getRiskLevelColor(widget.additives[additiveIndex].riskLevel!),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                widget.additives[additiveIndex].riskLevel!,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.info_outlined,
                      color: Color(0xFF40A5A5),
                      size: 19.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        int ingredientIndex = item['index'];
        widgets.add(
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
            child: InkWell(
              onTap: () {
                // TODO: Add ingredient info dialog if needed
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            IngredientsService.getLocalizedName(widget.ingredients[ingredientIndex], context),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                ),
                          ),
                          if (widget.ingredients[ingredientIndex].dbIngredient?.riskLevel != null) ...[
                            const SizedBox(width: 8.0),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: IngredientsService.getRiskLevel(widget.ingredients[ingredientIndex].dbIngredient!.riskLevel)['color'],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                IngredientsService.getRiskLevel(widget.ingredients[ingredientIndex].dbIngredient!.riskLevel)['text'],
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      totalItems++;
    }

         return widgets;
   }

  /// Get risk score for sorting (higher score = higher risk)
  int _getRiskScore(String? riskLevel) {
    switch (riskLevel?.toLowerCase()) {
      case 'high risk':
        return 4;
      case 'moderate risk':
        return 3;
      case 'low risk':
        return 2;
      case 'free risk':
        return 1;
      default:
        return 0; // Unknown gets lowest priority
    }
  }

  /// Check if we should show the "Show More" button
  bool _shouldShowMoreButton() {
    int totalItems = widget.additives.length + widget.ingredients.length;
    return totalItems > 5;
  }

  /// Get the count of remaining items to show
  int _getRemainingCount() {
    int totalItems = widget.additives.length + widget.ingredients.length;
    return totalItems - 5;
  }
}
