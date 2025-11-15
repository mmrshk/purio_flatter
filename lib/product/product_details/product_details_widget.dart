import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/services/history_service.dart';
import '/services/favorites_service.dart';
import '/services/additives_service.dart';
import '/services/health_score_service.dart';
import '/components/recommendations_widget.dart';
import '/components/additives_ingredients_section_widget.dart';
import '/components/all_ingredients_widget.dart';
import '/components/product_image_placeholder.dart';
import '/components/photo_popup_widget.dart';
import '/components/nutritional_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_details_model.dart';
export 'product_details_model.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    required this.product,
    this.fromScan = false,
  });

  final ProductRow product;
  final bool fromScan;

  static String routeName = 'ProductDetails';
  static String routePath = '/productDetails';

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget>
    with RouteAware {
  late ProductDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailsModel());

    // Load ingredients and additives together, then update UI once
    _loadIngredientsAndAdditives();

    // Load recommendations
    _loadRecommendations();

    // Add product to user's history
    HistoryService.addToHistory(widget.product.id);

    // Check if product is in favorites
    _checkFavoriteStatus();
  }

  Future<void> _loadIngredientsAndAdditives() async {
    // Load both ingredients and additives in parallel
    await Future.wait([
      _loadIngredients(),
      _model.loadAdditives(widget.product.id, context),
    ]);

    // Update UI once both are loaded
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      _model.isLoadingFavorite = true;
      if (mounted) setState(() {});

      final isFavorite = await FavoritesService.isFavorite(widget.product.id);

      if (mounted) {
        setState(() {
          _model.isFavorite = isFavorite;
          _model.isLoadingFavorite = false;
        });
      }
    } catch (e) {
      print('Error checking favorite status: $e');
      if (mounted) {
        setState(() {
          _model.isLoadingFavorite = false;
        });
      }
    }
  }

  Future<void> _loadIngredients() async {
    try {
      await _model.loadIngredients(widget.product.specifications);
      // Don't call setState here - we'll update UI after both ingredients and additives load
    } catch (e) {
      print('Error loading ingredients: $e');
    }
  }

  Future<void> _loadRecommendations() async {
    try {
      _model.isLoadingRecommendations = true;
      if (mounted) setState(() {});

      await _model.loadRecommendations(widget.product.id, widget.product.category ?? '');

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error loading recommendations: $e');
      if (mounted) {
        setState(() {
          _model.isLoadingRecommendations = false;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      _model.isLoadingFavorite = true;
      if (mounted) setState(() {});

      if (_model.isFavorite) {
        await FavoritesService.removeFromFavorites(widget.product.id);
        if (mounted) {
          setState(() {
            _model.isFavorite = false;
            _model.isLoadingFavorite = false;
          });
        }
      } else {
        await FavoritesService.addToFavorites(widget.product.id);
        if (mounted) {
          setState(() {
            _model.isFavorite = true;
            _model.isLoadingFavorite = false;
          });
        }
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      if (mounted) {
        setState(() {
          _model.isLoadingFavorite = false;
        });
      }
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(ProductDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _model.widget = widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = DebugModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
    debugLogGlobalProperty(context);
  }

  @override
  void didPopNext() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPush() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPop() {
    _model.isRouteVisible = false;
  }

  @override
  void didPushNext() {
    _model.isRouteVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);



    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
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
            widget.product.name,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 18,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100.0),
                    onTap: _model.isLoadingFavorite ? null : _toggleFavorite,
                    child: Center(
                      child: _model.isLoadingFavorite
                          ? const SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                color: Color(0xFF40A5A5),
                              ),
                            )
                          : Icon(
                              _model.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_sharp,
                              color: _model.isFavorite
                                  ? Colors.red
                                  : const Color(0xFF40A5A5),
                              size: 24.0,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 185.0,
                                              height: 185.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (widget.product.imageFrontUrl != null &&
                                                          widget.product.imageFrontUrl!.isNotEmpty) {
                                                        PhotoPopupWidget.show(
                                                          context,
                                                          widget.product.imageFrontUrl!,
                                                          productName: widget.product.name,
                                                        );
                                                      }
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(8.0),
                                                      child: widget.product.imageFrontUrl != null && widget.product.imageFrontUrl!.isNotEmpty
                                                          ? Image.network(
                                                              widget.product.imageFrontUrl!,
                                                              width: 185.0,
                                                              height: 125.0,
                                                              fit: BoxFit.contain,
                                                              errorBuilder: (context, error, stackTrace) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(top: 12.0),
                                                                  child: ProductImagePlaceholder(
                                                                    width: 120.0,
                                                                    height: 100.0,
                                                                    borderRadius: 8.0,
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          : Padding(
                                                              padding: const EdgeInsets.only(top: 12.0),
                                                              child: ProductImagePlaceholder(
                                                                width: 120.0,
                                                                height: 100.0,
                                                                borderRadius: 8.0,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  // Show scoring only if available, otherwise show "No scoring"
                                                  Builder(
                                                    builder: (context) {
                                                      final score = widget.product.displayScore ?? widget.product.healthScore;
                                                      if (score != null) {
                                                        return Container(
                                                          width: double.infinity,
                                                          height: 50.0,
                                                          decoration: BoxDecoration(
                                                            color: HealthScoreService.getHealthScoreColor(score),
                                                            borderRadius: const BorderRadius.only(
                                                              bottomLeft: Radius.circular(16.0),
                                                              bottomRight: Radius.circular(16.0),
                                                              topLeft: Radius.circular(0.0),
                                                              topRight: Radius.circular(0.0),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                '${FFLocalizations.of(context).getText('safety_label')}: $score/100',
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts.roboto(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors.white,
                                                                      fontSize: 15.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontStyle: FlutterFlowTheme.of(context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(const SizedBox(width: 5.0)),
                                                          ),
                                                        );
                                                      } else {
                                                        return Container(
                                                          width: double.infinity,
                                                          height: 50.0,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[300],
                                                            borderRadius: const BorderRadius.only(
                                                              bottomLeft: Radius.circular(16.0),
                                                              bottomRight: Radius.circular(16.0),
                                                              topLeft: Radius.circular(0.0),
                                                              topRight: Radius.circular(0.0),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(context).getText('no_scoring'),
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts.roboto(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors.grey[600],
                                                                      fontSize: 15.0,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontStyle: FlutterFlowTheme.of(context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(const SizedBox(width: 5.0)),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width * 0.8,
                                              ),
                                              child: SelectableText(
                                                widget.product.name,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                textAlign: TextAlign.center,
                                                contextMenuBuilder: (context, editableTextState) {
                                                  return AdaptiveTextSelectionToolbar(
                                                    anchors: editableTextState.contextMenuAnchors,
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          final text = editableTextState.textEditingValue.text;
                                                          final selection = editableTextState.textEditingValue.selection;
                                                          final selectedText = text.substring(selection.start, selection.end);
                                                          Clipboard.setData(ClipboardData(text: selectedText));
                                                          editableTextState.hideToolbar();
                                                        },
                                                        child: const Text('Copy'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            if (widget.product.specifications?['origin_country'] != null &&
                                                widget.product.specifications!['origin_country'].toString().isNotEmpty)
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                                                ),
                                                child: Text(
                                                  widget.product.specifications!['origin_country'],
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.roboto(
                                                          fontWeight: FontWeight.normal,
                                                          fontStyle:FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: const Color(0xFF6A7F98),
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.normal,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Nutritional Information Section - right after name/country
                              NutritionalInfoWidget(
                                nutritionalData: widget.product.nutritional,
                              ),
                              const SizedBox(height: 16.0),
                              // Combined Additives & Ingredients Section
                              AdditivesIngredientsSectionWidget(
                                additives: _model.additives,
                                ingredients: _model.ingredients,
                                visibleIngredientsCount: _model.visibleIngredientsCount,
                                hasMoreIngredients: _model.hasMoreIngredients,
                                onShowMore: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AllIngredientsWidget(
                                        additives: _model.additives,
                                        ingredients: _model.ingredients,
                                        rawIngredientsText: _model.rawIngredientsText,
                                        onAdditiveTap: (additive) => AdditivesService.showAdditiveInfoDialog(additive, context),
                                      ),
                                    ),
                                  );
                                },
                                onAdditiveTap: (additive) => AdditivesService.showAdditiveInfoDialog(additive, context),
                                onSeeAll: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AllIngredientsWidget(
                                        additives: _model.additives,
                                        ingredients: _model.ingredients,
                                        rawIngredientsText: _model.rawIngredientsText,
                                        onAdditiveTap: (additive) => AdditivesService.showAdditiveInfoDialog(additive, context),
                                      ),
                                    ),
                                  );
                                },

                                isLoadingIngredients: _model.isLoadingIngredients || _model.isLoadingAdditives,
                                rawIngredientsText: _model.rawIngredientsText,
                              ),
                              // Recommendations Section
                              RecommendationsWidget(
                                recommendedProduct: _model.recommendedProduct,
                                isLoading: _model.isLoadingRecommendations,
                                currentProduct: widget.product,
                              ),

                              InkWell(
                                onTap: () {
                                  context.pushNamed('ScoringMethod');
                                },
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFF5F5F5), Colors.white],
                                      stops: [0.0, 1.0],
                                      begin: AlignmentDirectional(1.0, 0.0),
                                      end: AlignmentDirectional(-1.0, 0),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context).getText(
                                                  't0jrl3ay' /* Scoring Method */,
                                                ),
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context).getText(
                                                  'pus9jfji' /* Learn how products are rated */,
                                                ),
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: const Color(0xFF6A7F98),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Color(0xFF40A5A5),
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
