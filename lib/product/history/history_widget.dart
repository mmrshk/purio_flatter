import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/shimmer_util.dart';
import '/components/product_image_placeholder.dart';
import '/services/history_service.dart';
import '/services/favorites_service.dart';
import '/services/health_score_service.dart';
import 'history_model.dart';
export 'history_model.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  static String routeName = 'History';
  static String routePath = '/history';

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> with RouteAware {
  late HistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  bool _isRecentTab = true;
  Set<int> _loadedImageIndexes = {};
  final Map<int, DateTime> _imageLoadStartTimes = {};
  final int _minSkeletonMillis = 300;
  bool _isLoadingHistory = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryModel());
    _loadHistoryProducts();
  }

  Future<void> _loadHistoryProducts() async {
    setState(() {
      _isLoadingHistory = true;
    });
    
    // Record start time for minimum loading duration
    final startTime = DateTime.now();
    
    try {
      final products = await HistoryService.getUserHistory(limit: 10);
      
      if (mounted) {
        // Calculate elapsed time
        final elapsed = DateTime.now().difference(startTime).inMilliseconds;
        final minLoadingTime = 2000; // 2 seconds minimum loading time
        
        if (elapsed < minLoadingTime) {
          // Wait for remaining time to complete minimum loading duration
          await Future.delayed(Duration(milliseconds: minLoadingTime - elapsed));
        }
        
        setState(() {
          _model.historyProducts = products;
          _isLoadingHistory = false;
        });
      }
    } catch (e) {
      print('Error loading history products: $e');
      
      if (mounted) {
        // Even on error, ensure minimum loading time
        final elapsed = DateTime.now().difference(startTime).inMilliseconds;
        final minLoadingTime = 500;
        
        if (elapsed < minLoadingTime) {
          await Future.delayed(Duration(milliseconds: minLoadingTime - elapsed));
        }
        
        setState(() {
          _isLoadingHistory = false;
        });
      }
    }
  }

  Future<void> _loadFavoriteProducts() async {
    setState(() {
      _model.isLoadingFavorites = true;
    });
    
    try {
      final products = await FavoritesService.getUserFavorites(limit: 10);
      
      if (mounted) {
        setState(() {
          _model.favoriteProducts = products;
          _model.isLoadingFavorites = false;
        });
      }
    } catch (e) {
      print('Error loading favorite products: $e');
      
      if (mounted) {
        setState(() {
          _model.isLoadingFavorites = false;
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
  void didUpdateWidget(HistoryWidget oldWidget) {
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
      
      // Refresh favorites when returning to this page
      if (!_isRecentTab && !_model.isLoadingFavorites) {
        _loadFavoriteProducts();
      }
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
            FFLocalizations.of(context).getText('ymharo6a' /* History */),
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
            children: [
              // Tab Buttons
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRecentTab = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: _isRecentTab ? const Color(0xFF40E0D0) : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF40E0D0),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'recent' /* Recent */,
                              ),
                              style: TextStyle(
                                color: _isRecentTab ? Colors.white : const Color(0xFF40E0D0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRecentTab = false;
                          });
                          // Load favorites when switching to favorites tab
                          if (_model.favoriteProducts.isEmpty && !_model.isLoadingFavorites) {
                            _loadFavoriteProducts();
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: !_isRecentTab ? const Color(0xFF40E0D0) : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF40E0D0),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'favorites' /* Favorites */,
                              ),
                              style: TextStyle(
                                color: !_isRecentTab ? Colors.white : const Color(0xFF40E0D0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Recent Tab Content
                      if (_isRecentTab) ...[
                        if (_isLoadingHistory) ...[
                          // Show loading state with skeletons
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Show skeleton placeholders while loading
                                  ...List.generate(3, (index) => historyProductSkeleton()),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            const Color(0xFF40E0D0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'loading_history' /* Loading your history... */
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ] else if (_model.historyProducts.isEmpty) ...[
                          Text(
                            FFLocalizations.of(context).getText(
                              'no_history' /* No history yet */
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            FFLocalizations.of(context).getText(
                              'your_recently_viewed_products_will_appear_here' /* Your recently viewed products will appear here */
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ] else ...[
                          Shimmer(
                            linearGradient: shimmerGradient,
                            child: Expanded(
                              child: ListView.builder(
                                itemCount: _model.historyProducts.length,
                                itemBuilder: (context, index) {
                                  final product = _model.historyProducts[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Column(
                                      children: [
                                        InkWell(
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
                                                ShimmerLoading(
                                                  isLoading: !_loadedImageIndexes.contains(index),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    child: (product.imageFrontUrl?.isNotEmpty == true)
                                                        ? Image.network(
                                                            product.imageFrontUrl ?? '',
                                                            width: 66.0,
                                                            height: 66.0,
                                                            fit: BoxFit.cover,
                                                            loadingBuilder: (context, child, loadingProgress) {
                                                              if (!_imageLoadStartTimes.containsKey(index)) {
                                                                _imageLoadStartTimes[index] = DateTime.now();
                                                              }
                                                              if (loadingProgress == null) {
                                                                final loadStart = _imageLoadStartTimes[index]!;
                                                                final elapsed = DateTime.now().difference(loadStart).inMilliseconds;
                                                                if (elapsed < _minSkeletonMillis) {
                                                                  Future.delayed(Duration(milliseconds: _minSkeletonMillis - elapsed), () {
                                                                    if (mounted) setState(() {
                                                                      _loadedImageIndexes.add(index);
                                                                    });
                                                                  });
                                                                  return Container(
                                                                    width: 66.0,
                                                                    height: 66.0,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.grey[300],
                                                                      borderRadius: BorderRadius.circular(16.0),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                    if (mounted) setState(() {
                                                                      _loadedImageIndexes.add(index);
                                                                    });
                                                                  });
                                                                  return child;
                                                                }
                                                              } else {
                                                                return Container(
                                                                  width: 66.0,
                                                                  height: 66.0,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.grey[300],
                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            errorBuilder: (context, error, stackTrace) {
                                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                if (mounted) setState(() {
                                                                  _loadedImageIndexes.add(index);
                                                                });
                                                              });
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
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: ShimmerLoading(
                                                    isLoading: !_loadedImageIndexes.contains(index),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          product.name ?? '',
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts.roboto(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontStyle: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors.black,
                                                                fontSize: 16.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          product.description ?? '',
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts.roboto(
                                                                  fontWeight: FontWeight.normal,
                                                                  fontStyle: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors.black54,
                                                                fontSize: 13.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.normal,
                                                                fontStyle: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        const SizedBox(height: 6),
                                                        if (product.healthScore != null)
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                            decoration: BoxDecoration(
                                                              color: HealthScoreService.getHealthScoreColor(product.displayScore ?? product.healthScore ?? 0),
                                                              borderRadius: BorderRadius.circular(30.0),
                                                            ),
                                                            child: Text(
                                                              'Safety: ${product.displayScore ?? product.healthScore ?? 0}',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts.roboto(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontStyle: FlutterFlowTheme.of(context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors.white,
                                                                    fontSize: 12.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontStyle: FlutterFlowTheme.of(context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ],
                      // Favorites Tab Content
                      if (!_isRecentTab) ...[
                        if (_model.isLoadingFavorites) ...[
                          // Show loading state with skeletons
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Show skeleton placeholders while loading
                                  ...List.generate(3, (index) => historyProductSkeleton()),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            const Color(0xFF40E0D0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Loading favorites...',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else if (_model.favoriteProducts.isEmpty) ...[
                          Text(
                            FFLocalizations.of(context).getText(
                              'no_favorites' /* No favorites yet */
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            FFLocalizations.of(context).getText(
                              'your_favorite_products_will_appear_here' /* Your favorite products will appear here */
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ] else ...[
                          // Show favorites list
                          Expanded(
                            child: ListView.builder(
                              itemCount: _model.favoriteProducts.length,
                              itemBuilder: (context, index) {
                                final product = _model.favoriteProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        'ProductDetails',
                                        extra: <String, dynamic>{
                                          'product': product,
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                            // Product image
                                            Container(
                                              width: 66.0,
                                              height: 66.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(16.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: product.imageFrontUrl != null && product.imageFrontUrl!.isNotEmpty
                                                    ? Image.network(
                                                        product.imageFrontUrl!,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return ProductImagePlaceholder(
                                                            borderRadius: 16.0,
                                                          );
                                                        },
                                                      )
                                                    : ProductImagePlaceholder(
                                                        borderRadius: 16.0,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            // Product details
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.name ?? 'Unknown Product',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black87,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    product.category ?? 'No category',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      if (product.healthScore != null)
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                          decoration: BoxDecoration(
                                                            color: HealthScoreService.getHealthScoreColor(product.displayScore ?? product.healthScore ?? 0),
                                                            borderRadius: BorderRadius.circular(30.0),
                                                          ),
                                                          child: Text(
                                                            'Safety: ${product.displayScore ?? product.healthScore ?? 0}',
                                                            style: FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts.roboto(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontStyle: FlutterFlowTheme.of(context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors.white,
                                                                  fontSize: 12.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontStyle: FlutterFlowTheme.of(context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget historyProductSkeleton() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
            // Image skeleton
            Container(
              width: 66.0,
              height: 66.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            const SizedBox(width: 12),
            // Text skeletons
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 100,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.0),
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
