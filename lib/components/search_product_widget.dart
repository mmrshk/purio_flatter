import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/shimmer_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_product_model.dart';
import '/backend/supabase/database/tables/product.dart';
import '/backend/supabase/supabase.dart';
import '/index.dart';
export 'search_product_model.dart';

class SearchProductWidget extends StatefulWidget {
  const SearchProductWidget({super.key, required this.product, required this.query, this.isLoaded = false, this.onImageLoaded});

  final ProductRow product;
  final String query;
  final bool isLoaded;
  final VoidCallback? onImageLoaded;

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget>
    with RouteAware {
  late SearchProductModel _model;
  final int _pageSize = 10;
  int _offset = 0;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;
  List<ProductRow> _searchResults = [];
  final Set<int> _loadedImageIndexes = {};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchProductModel());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && _hasMore && !_isSearching) {
        _fetchProducts(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.maybeDispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(SearchProductWidget oldWidget) {
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

  Future<void> _fetchProducts({bool loadMore = false}) async {
    if (!loadMore) {
      _offset = 0;
      _searchResults.clear();
      _hasMore = true;
    }
    setState(() => _isSearching = true);
    final query = widget.query.trim();
    final results = await Supabase.instance.client
        .from('products')
        .select()
        .ilike('name', '%$query%')
        .range(_offset, _offset + _pageSize - 1);
    final products = (results as List)
        .map((e) => ProductRow(e as Map<String, dynamic>))
        .toList();
    setState(() {
      if (loadMore) {
        _searchResults.addAll(products);
      } else {
        _searchResults = products;
      }
      _isSearching = false;
      _hasMore = products.length == _pageSize;
      _offset += products.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);

    final product = widget.product;

    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 17.0),
        child: InkWell(
            onTap: () {
              context.pushNamed(
                ProductDetailsWidget.routeName,
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
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer(
                        linearGradient: shimmerGradient,
                        child: ShimmerLoading(
                          isLoading: !widget.isLoaded,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: (product.imageFrontUrl?.isNotEmpty == true)
                                ? Image.network(
                                    product.imageFrontUrl ?? '',
                                    width: 66.0,
                                    height: 66.0,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          if (mounted) {
                                            widget.onImageLoaded?.call();
                                          }
                                        });
                                        return child;
                                      } else {
                                        return Container(
                                          width: 66.0,
                                          height: 66.0,
                                          color: Colors.grey[300],
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        if (mounted) {
                                          widget.onImageLoaded?.call();
                                        }
                                      });
                                      return Container(
                                        width: 66.0,
                                        height: 66.0,
                                        color: Colors.grey[300],
                                      );
                                    },
                                  )
                                : Container(
                                    width: 66.0,
                                    height: 66.0,
                                    color: Colors.grey[300],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child:                         Shimmer(
                          linearGradient: shimmerGradient,
                          child: ShimmerLoading(
                            isLoading: !widget.isLoaded,
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
                                      color: const Color(0xFF2ECC71),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Text(
                                      'Safety: ${product.healthScore ?? 0}',
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
