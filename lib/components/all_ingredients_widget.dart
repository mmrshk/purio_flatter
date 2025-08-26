import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
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
  }
  
  /// Check if ingredient has a description
  bool _hasIngredientDescription(MatchedIngredient ingredient) {
    if (ingredient.dbIngredient == null) return false;
    
    final currentLanguage = FFLocalizations.of(context).languageCode;
    
    if (currentLanguage == 'ro') {
      return ingredient.dbIngredient!.roDescription != null && 
             ingredient.dbIngredient!.roDescription!.isNotEmpty;
    }
    
    return ingredient.dbIngredient!.description != null && 
           ingredient.dbIngredient!.description!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 100.0,
                  borderWidth: 1.0,
                  buttonSize: 45.0,
                  fillColor: const Color(0xFFFAF9F9),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF40A5A5),
                    size: 24.0,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      FFLocalizations.of(context).getText('9bs48st0' /* Ingredients */),
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                            ),
                            color: Colors.black,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 45.0),
              ],
            ),
            actions: const [],
            centerTitle: true,
            elevation: 1.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE6F7F5), Colors.white],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(23.0, 0.0, 23.0, 0.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Combined Ingredients Container
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
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
                                      const SizedBox(height: 12.0),
                                      // Information text about ingredient order
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: const Color(0xFF40A5A5),
                                            width: 1.2,
                                          ),
                                        ),
                                        child: Text(
                                          FFLocalizations.of(context).getText('ingredients_order_info'),
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                ),
                                                color: const Color(0xFF6C757D),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                              ),
                                        ),
                                      ),
                                      if (widget.additives.isNotEmpty || widget.ingredients.isNotEmpty) ...[
                                        const SizedBox(height: 16.0),
                                        // Additives
                                        ...List.generate(
                                          widget.additives.length,
                                          (index) {
                                            int additiveIndex = index;
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
                                                            Flexible(
                                                              child: Text(
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
                                                                softWrap: true,
                                                                overflow: TextOverflow.visible,
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
                                          },
                                        ),
                                        // Ingredients
                                        ...List.generate(
                                          widget.ingredients.length,
                                          (index) {
                                            int ingredientIndex = index;
                                            return Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (_hasIngredientDescription(widget.ingredients[ingredientIndex])) {
                                                    IngredientsService.showIngredientInfoDialog(widget.ingredients[ingredientIndex], context);
                                                  }
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
                                                            Flexible(
                                                              child: Text(
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
                                                                softWrap: true,
                                                                overflow: TextOverflow.visible,
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
                                                      if (_hasIngredientDescription(widget.ingredients[ingredientIndex]))
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
                                          },
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Raw Ingredients Text Container
                              if (widget.rawIngredientsText != null && widget.rawIngredientsText!.isNotEmpty) ...[
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
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
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
