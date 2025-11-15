import '/components/search_product_widget.dart';
import '/components/product_image_placeholder.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
import '/product/product_details/product_details_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'popular_scans_model.dart';
import '/backend/supabase/database/tables/product.dart';
import '/backend/supabase/supabase.dart';
import '/services/popular_products_service.dart';
import '/services/favorites_service.dart';
import '/services/health_score_service.dart';
export 'popular_scans_model.dart';

class PopularScansWidget extends StatefulWidget {
  const PopularScansWidget({super.key});

  static String routeName = 'PopularScans';
  static String routePath = '/popular-scans';

  @override
  State<PopularScansWidget> createState() => _PopularScansWidgetState();
}

class _PopularScansWidgetState extends State<PopularScansWidget> with RouteAware {
  late PopularScansModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<ProductRow> _popularProducts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  final int _minLoadingMillis = 1200;
  final int _pageSize = 8;
  int _currentPage = 0;
  Map<String, bool> _favoriteStatus = {};
  Map<String, bool> _isLoadingFavorite = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PopularScansModel());
    _fetchPopularProducts();
  }

  Future<void> _checkFavoriteStatus(String productId) async {
    try {
      setState(() {
        _isLoadingFavorite[productId] = true;
      });

      final isFavorite = await FavoritesService.isFavorite(productId);

      if (mounted) {
        setState(() {
          _favoriteStatus[productId] = isFavorite;
          _isLoadingFavorite[productId] = false;
        });
      }
    } catch (e) {
      print('Error checking favorite status: $e');
      if (mounted) {
        setState(() {
          _isLoadingFavorite[productId] = false;
        });
      }
    }
  }

  Future<void> _toggleFavorite(String productId) async {
    try {
      setState(() {
        _isLoadingFavorite[productId] = true;
      });

      final isCurrentlyFavorite = _favoriteStatus[productId] ?? false;

      if (isCurrentlyFavorite) {
        await FavoritesService.removeFromFavorites(productId);
      } else {
        await FavoritesService.addToFavorites(productId);
      }

      if (mounted) {
        setState(() {
          _favoriteStatus[productId] = !isCurrentlyFavorite;
          _isLoadingFavorite[productId] = false;
        });
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      if (mounted) {
        setState(() {
          _isLoadingFavorite[productId] = false;
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
  void didUpdateWidget(PopularScansWidget oldWidget) {
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

  Future<void> _fetchPopularProducts({bool loadMore = false}) async {
    if (!loadMore) {
      _currentPage = 0;
      _popularProducts.clear();
      _hasMore = true;
      setState(() => _isLoading = true);
    } else {
      setState(() => _isLoadingMore = true);
    }

    final loadStart = DateTime.now();

    try {
      final products = await PopularProductsService.instance.getPopularProducts(
        limit: _pageSize * (_currentPage + 1)
      );

      final elapsed = DateTime.now().difference(loadStart).inMilliseconds;
      if (elapsed < _minLoadingMillis && !loadMore) {
        await Future.delayed(Duration(milliseconds: _minLoadingMillis - elapsed));
      }

      setState(() {
        if (loadMore) {
          _popularProducts.addAll(products.skip(_currentPage * _pageSize));
        } else {
          _popularProducts = products;
        }
        _currentPage++;
        _hasMore = products.length >= _pageSize * _currentPage;
        _isLoading = false;
        _isLoadingMore = false;
      });

      // Check favorite status for all products
      for (final product in products) {
        _checkFavoriteStatus(product.id);
      }
    } catch (e) {
      print('Error fetching popular products: $e');
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);
    context.watch<FFAppState>();

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
            'Popular Scans',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22,
                ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: _isLoading
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
                        'Loading popular scans...',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                )
              : _popularProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 64,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No popular scans yet',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Popular scans will appear here once users start scanning products',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _fetchPopularProducts(loadMore: false),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: _popularProducts.length + (_hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _popularProducts.length) {
                            return _buildLoadMoreButton();
                          }
                          final product = _popularProducts[index];
                          return _buildProductCard(product, index);
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _isLoadingMore ? null : () => _fetchPopularProducts(loadMore: true),
          child: Center(
            child: _isLoadingMore
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Load More',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductRow product, int index) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          ProductDetailsWidget.routeName,
          extra: <String, dynamic>{
            'product': product,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE3F2FD), // Light blue border
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with favorite icon
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _toggleFavorite(product.id),
                  child: _isLoadingFavorite[product.id] == true
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF2196F3),
                            ),
                          ),
                        )
                      : Icon(
                          _favoriteStatus[product.id] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _favoriteStatus[product.id] == true
                              ? Colors.red
                              : const Color(0xFF2196F3), // Light blue
                          size: 20,
                        ),
                ),
              ],
            ),
          ),
          // Product image
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                child: product.imageFrontUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageFrontUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return ProductImagePlaceholder(
                              width: 80,
                              height: 80,
                              borderRadius: 8,
                            );
                          },
                        ),
                      )
                    : ProductImagePlaceholder(
                        width: 80,
                        height: 80,
                        borderRadius: 8,
                      ),
              ),
            ),
          ),
          // Safety rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Builder(
              builder: (context) {
                final score = product.displayScore ?? product.healthScore;
                if (score != null) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: HealthScoreService.getHealthScoreColor(score),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${FFLocalizations.of(context).getText('safety_label')}: $score/100',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      FFLocalizations.of(context).getText('no_scoring'),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          // Product name
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              product.name,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        ),
      ),
    );
  }
}
