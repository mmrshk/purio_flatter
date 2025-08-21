import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
import '/backend/supabase/supabase.dart';
import '/services/additives_service.dart';
import '/services/ingredients_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllIngredientsWidget extends StatefulWidget {
  const AllIngredientsWidget({
    Key? key,
    required this.additives,
    required this.ingredients,
    required this.rawIngredientsText,
    required this.onAdditiveTap,
  }) : super(key: key);

  final List<AdditivesRow> additives;
  final List<MatchedIngredient> ingredients;
  final String? rawIngredientsText;
  final Function(AdditivesRow) onAdditiveTap;

  @override
  State<AllIngredientsWidget> createState() => _AllIngredientsWidgetState();
}

class _AllIngredientsWidgetState extends State<AllIngredientsWidget> {
  late List<Map<String, dynamic>> _sortedItems;
  
  @override
  void initState() {
    super.initState();
    _sortedItems = _sortItemsByRawTextOrder();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          FFLocalizations.of(context).getText('9bs48st0' /* Ingredients */),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: Colors.black,
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Combined Sorted Ingredients List
            if (_sortedItems.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 12.0),
                child: Text(
                  FFLocalizations.of(context).getText('9bs48st0' /* Ingredients */),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Colors.black,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              ...List.generate(
                _sortedItems.length,
                (index) {
                  var item = _sortedItems[index];
                  
                  if (item['type'] == 'additive') {
                    int additiveIndex = item['index'];
                    return Padding(
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
                    );
                  } else {
                    int ingredientIndex = item['index'];
                    return Padding(
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
                    );
                  }
                },
              ),
            ],
            
            // Raw Ingredients Text Container
            if (widget.rawIngredientsText != null && widget.rawIngredientsText!.isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFFE9ECEF),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText('raw_ingredients'),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: Colors.black,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      widget.rawIngredientsText!,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: const Color(0xFF6C757D),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sort items (additives and ingredients) by their order in raw ingredients text
  List<Map<String, dynamic>> _sortItemsByRawTextOrder() {
    List<Map<String, dynamic>> allItems = [];
    String rawText = widget.rawIngredientsText?.toLowerCase() ?? '';
    
    // Add additives with their position in raw text
    for (int i = 0; i < widget.additives.length; i++) {
      var additive = widget.additives[i];
      String additiveName = additive.name.toLowerCase();
      int position = rawText.indexOf(additiveName);
      allItems.add({
        'type': 'additive',
        'index': i,
        'position': position >= 0 ? position : 999999, // Put unmatched items at the end
        'name': additiveName,
      });
    }
    
    // Add ingredients with their position in raw text
    for (int i = 0; i < widget.ingredients.length; i++) {
      var ingredient = widget.ingredients[i];
      String ingredientName = ingredient.originalName.toLowerCase();
      int position = rawText.indexOf(ingredientName);
      allItems.add({
        'type': 'ingredient',
        'index': i,
        'position': position >= 0 ? position : 999999, // Put unmatched items at the end
        'name': ingredientName,
      });
    }
    
    // Sort by position (first appearance in raw text = most used)
    allItems.sort((a, b) => a['position'].compareTo(b['position']));
    
    return allItems;
  }
}
