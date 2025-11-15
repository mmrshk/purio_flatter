import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/backend/supabase/supabase.dart';
import '/services/recommendations_service.dart';
import '/services/health_score_service.dart';
import '/components/product_image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'recommendations_list_model.dart';
export 'recommendations_list_model.dart';

class RecommendationsListWidget extends StatefulWidget {
  const RecommendationsListWidget({
    super.key,
    required this.currentProduct,
  });

  final ProductRow currentProduct;

  static String routeName = 'RecommendationsList';
  static String routePath = '/recommendationsList';

  @override
  State<RecommendationsListWidget> createState() => _RecommendationsListWidgetState();
}

class _RecommendationsListWidgetState extends State<RecommendationsListWidget> with RouteAware {
  late RecommendationsListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecommendationsListModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _fetchRecommendations();
    });
  }

  Future<void> _fetchRecommendations() async {
    try {
      _model.isLoading = true;
      if (mounted) setState(() {});

      final healthScore = widget.currentProduct.displayScore ?? widget.currentProduct.healthScore;
      final category = widget.currentProduct.category ?? '';

      List<ProductRow> recommendations;

      if (healthScore != null) {
        // Product has a score, get products with same or higher score
        recommendations = await RecommendationsService.getProductsWithSameOrHigherScore(
          healthScore,
          widget.currentProduct.id,
          category,
        );
      } else {
        // Product has no score, get products with score bigger than 50
        recommendations = await RecommendationsService.getProductsWithScoreBiggerThan50(
          widget.currentProduct.id,
          category,
        );
      }

      if (mounted) {
        setState(() {
          _model.recommendations = recommendations;
          _model.isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
      if (mounted) {
        setState(() {
          _model.isLoading = false;
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
  void didUpdateWidget(RecommendationsListWidget oldWidget) {
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
                    context.safePop();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Better Alternatives',
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                            child: Builder(
                              builder: (context) {
                                final currentScore = widget.currentProduct.displayScore ?? widget.currentProduct.healthScore;
                                final subtitle = currentScore != null
                                    ? 'Products with same or higher safety score ($currentScore/100)'
                                    : 'Products with safety score bigger than 50';

                                return Text(
                                  subtitle,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                    ),
                                    color: const Color(0xFF6A7F98),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: _model.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      color: Color(0xFF40A5A5),
                                    ),
                                  )
                                : _model.recommendations.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.search_off,
                                              size: 64,
                                              color: Colors.grey[400],
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              'No better alternatives found',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                                    color: Colors.grey[600],
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'This product already has a good safety score!',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.normal,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                                    color: Colors.grey[500],
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: _model.recommendations.length,
                                        itemBuilder: (context, index) {
                                          final product = _model.recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 12.0),
                                            child: InkWell(
                                              onTap: () {
                                                context.pushNamed(
                                                  'ProductDetails',
                                                  extra: <String, dynamic>{
                                                    'product': product,
                                                  },
                                                );
                                              },
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.05),
                                                      blurRadius: 4,
                                                      offset: const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(16.0),
                                                        child: (product.imageFrontUrl?.isNotEmpty == true)
                                                            ? Image.network(
                                                                product.imageFrontUrl ?? '',
                                                                width: 66.0,
                                                                height: 66.0,
                                                                fit: BoxFit.cover,
                                                                errorBuilder: (context, error, stackTrace) {
                                                                  return ProductImagePlaceholder(
                                                                    width: 66.0,
                                                                    height: 66.0,
                                                                    borderRadius: 16.0,
                                                                  );
                                                                },
                                                              )
                                                            : ProductImagePlaceholder(
                                                                width: 66.0,
                                                                height: 66.0,
                                                                borderRadius: 16.0,
                                                              ),
                                                      ),
                                                      const SizedBox(width: 12.0),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              product.category ?? 'Category',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                                                                    color: const Color(0xFF6A7F98),
                                                                    fontSize: 12.0,
                                                                  ),
                                                            ),
                                                            const SizedBox(height: 4.0),
                                                            Text(
                                                              product.name ?? 'Product Name',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                                                    color: Colors.black,
                                                                    fontSize: 16.0,
                                                                  ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            const SizedBox(height: 8.0),
                                                            Builder(
                                                              builder: (context) {
                                                                final score = product.displayScore ?? product.healthScore;
                                                                if (score != null) {
                                                                  return Container(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                    decoration: BoxDecoration(
                                                                      color: HealthScoreService.getHealthScoreColor(score),
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                    ),
                                                                    child: Text(
                                                                      '${FFLocalizations.of(context).getText('safety_label')}: $score/100',
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                                                            color: Colors.white,
                                                                            fontSize: 12.0,
                                                                          ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.grey[300],
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                    ),
                                                                    child: Text(
                                                                      FFLocalizations.of(context).getText('no_scoring'),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                            font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                                                            color: Colors.grey[600],
                                                                            fontSize: 12.0,
                                                                          ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color(0xFF40A5A5),
                                                        size: 16.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
    );
  }
}
