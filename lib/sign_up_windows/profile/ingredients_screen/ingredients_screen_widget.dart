import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/ingredients_service.dart';
import 'package:flutter/material.dart';
import 'ingredients_screen_model.dart';

export 'ingredients_screen_model.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  late IngredientsScreenModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IngredientsScreenModel());
    _model.setOnUpdate(
      onUpdate: () {
        if (mounted) {
          setState(() {});
        }
      },
      updateOnChange: true,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText('9bs48st0' /* Ingredients */),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: TextFormField(
                  controller: _model.searchController ??= TextEditingController(),
                  focusNode: _model.searchFocusNode,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context).getText('search_ingredients'),
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                    prefixIcon: Icon(
                      Icons.search,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  onChanged: (value) {
                    _model.onSearchChanged(value);
                  },
                ),
              ),
              Expanded(
                child: _model.isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Loading ingredients...',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : _model.ingredientsList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _model.searchQuery.isEmpty
                                      ? 'No ingredients available'
                                      : 'No ingredients found',
                                  style: FlutterFlowTheme.of(context).bodyLarge,
                                ),
                                if (_model.searchQuery.isEmpty) ...[
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      _model.loadIngredients();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await _model.loadIngredients();
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              controller: _model.listViewController,
                              scrollDirection: Axis.vertical,
                              itemCount: _model.getFilteredIngredients().length + (_model.hasMoreData ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == _model.getFilteredIngredients().length) {
                                  return _model.isLoadingMore
                                      ? Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context).primary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }

                                final ingredient = _model.getFilteredIngredients()[index];
                                return _buildIngredientCard(ingredient);
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientCard(IngredientsRow ingredient) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
      child: InkWell(
        onTap: () {
          // Create a MatchedIngredient to use with the dialog
          final matchedIngredient = MatchedIngredient(
            originalName: ingredient.name,
            dbIngredient: ingredient,
            isMatched: true,
          );

          if (_hasIngredientDescription(matchedIngredient)) {
            IngredientsService.showIngredientInfoDialog(matchedIngredient, context);
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            FFLocalizations.of(context).languageCode == 'ro'
                                ? (ingredient.roName ?? ingredient.name)
                                : ingredient.name,
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 8),
                          if (ingredient.riskLevel != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: IngredientsService.getRiskLevel(ingredient.riskLevel, context)['color'],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                IngredientsService.getRiskLevel(ingredient.riskLevel, context)['text'],
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (_hasIngredientDescription(MatchedIngredient(
                        originalName: ingredient.name,
                        dbIngredient: ingredient,
                        isMatched: true,
                      ))) ...[
                        Text(
                          IngredientsService.getLocalizedDescription(MatchedIngredient(
                            originalName: ingredient.name,
                            dbIngredient: ingredient,
                            isMatched: true,
                          ), context),
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasIngredientDescription(MatchedIngredient ingredient) {
    if (ingredient.dbIngredient == null) return false;

    final currentLanguage = FFLocalizations.of(context).languageCode;

    return currentLanguage == 'ro'
        ? ingredient.dbIngredient!.roDescription != null &&
          ingredient.dbIngredient!.roDescription!.isNotEmpty
        : ingredient.dbIngredient!.description != null &&
          ingredient.dbIngredient!.description!.isNotEmpty;
  }
}
