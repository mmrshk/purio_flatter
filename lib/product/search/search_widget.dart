import '/components/search_product_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_model.dart';
import '/backend/supabase/database/tables/product.dart';
import '/backend/supabase/supabase.dart';
export 'search_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  static String routeName = 'Search';
  static String routePath = '/search';

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> with RouteAware {
  late SearchModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _searchController = TextEditingController();
  List<ProductRow> _searchResults = [];
  bool _isSearching = false;
  Set<int> _loadedImageIndexes = {};
  final Map<int, DateTime> _imageLoadStartTimes = {};
  final int _minSkeletonMillis = 1200;
  final ScrollController _scrollController = ScrollController();
  bool _hasMore = true;
  final int _pageSize = 5;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchModel());
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _model.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.trim().isNotEmpty) {
      _fetchProducts(loadMore: false);
    } else {
      setState(() {
        _searchResults.clear();
        _isSearching = false;
      });
    }
  }

  @override
  void didUpdateWidget(SearchWidget oldWidget) {
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
      _loadedImageIndexes.clear();
      _imageLoadStartTimes.clear();
      setState(() => _isSearching = true);
    } else {
      // For load more, only update the loading state without full rebuild
      _isSearching = true;
    }
    
    final query = _searchController.text.trim();
    final results = await Supabase.instance.client
        .from('products')
        .select()
        .ilike('name', '%$query%')
        .eq('visible', true)
        .range(_offset, _offset + _pageSize - 1);
    final products = (results as List)
        .map((e) => ProductRow(e as Map<String, dynamic>))
        .toList();
    
    // Update state only once with all changes
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
            FFLocalizations.of(context).getText('cnw6hi6r' /* Search */),
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
                  controller: _searchController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Search products...',
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
                    prefixIcon: Icon(
                      Icons.search,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Expanded(
                child: _searchController.text.trim().isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              FFLocalizations.of(context).getText('orieo052' /* Find Your Product */),
                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Text(
                                FFLocalizations.of(context).getText('search_by_product_name_or_brand' /* Search by product name or brand and discover detailed insights instantly.  */),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontSize: 16,
                                    ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _isSearching
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
                                  'Searching products...',
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            ),
                          )
                        : _searchResults.isEmpty
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
                                      'No products found',
                                      style: FlutterFlowTheme.of(context).bodyLarge,
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await _fetchProducts(loadMore: false);
                                },
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  controller: _scrollController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _searchResults.length + (_hasMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == _searchResults.length) {
                                      return _isSearching
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
                                          : Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Center(
                                                child: Container(
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
                                                      onTap: () => _fetchProducts(loadMore: true),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color: FlutterFlowTheme.of(context).primary,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(width: 8),
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
                                              ),
                                            );
                                    }
                                    
                                    final product = _searchResults[index];
                                    if (!_imageLoadStartTimes.containsKey(index)) {
                                      _imageLoadStartTimes[index] = DateTime.now();
                                    }
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                                      child: SearchProductWidget(
                                        product: product,
                                        query: _searchController.text,
                                        isLoaded: _loadedImageIndexes.contains(index),
                                        onImageLoaded: () {
                                          if (!_loadedImageIndexes.contains(index)) {
                                            final loadStart = _imageLoadStartTimes[index]!;
                                            final elapsed = DateTime.now().difference(loadStart).inMilliseconds;
                                            if (elapsed < _minSkeletonMillis) {
                                              Future.delayed(Duration(milliseconds: _minSkeletonMillis - elapsed), () {
                                                if (mounted) setState(() {
                                                  _loadedImageIndexes.add(index);
                                                });
                                              });
                                            } else {
                                              setState(() {
                                                _loadedImageIndexes.add(index);
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    );
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
}
