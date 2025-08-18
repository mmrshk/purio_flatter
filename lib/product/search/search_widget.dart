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
    }
    setState(() => _isSearching = true);
    final query = _searchController.text.trim();
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
    context.watch<FFAppState>();

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
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                    child: SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'cnw6hi6r' /* Search */,
                            ),
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
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 78.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFAFAF),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Group.png',
                          width: 20.0,
                          height: 15.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/PRO_(1).png',
                          width: 31.0,
                          height: 15.0,
                          fit: BoxFit.none,
                        ),
                      ),
                    ],
                  ),
                ),
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
            padding: const EdgeInsetsDirectional.fromSTEB(29.0, 38.0, 29.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Search bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: const Color(0xFFEBEBEB),
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'e.g. Paine Vel Pitar',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: const Color(0xFF6A7F98),
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_searchController.text.trim().isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'orieo052' /* Find Your Product */,
                            ),
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            FFLocalizations.of(context).getText(
                              'search_by_product_name_or_brand' /* Search by product name or brand and discover detailed insights instantly.  */,
                            ),
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_isSearching)
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: CircularProgressIndicator(),
                  ),
                if (_searchController.text.trim().isNotEmpty && !_isSearching)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _searchResults.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < _searchResults.length) {
                          final product = _searchResults[index];
                          if (!_imageLoadStartTimes.containsKey(index)) {
                            _imageLoadStartTimes[index] = DateTime.now();
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
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
                        } else {
                          // Load more button at the bottom
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: _isSearching ? null : () => _fetchProducts(loadMore: true),
                                child: _isSearching ? CircularProgressIndicator() : Text('Load more'),
                              ),
                            ),
                          );
                        }
                      },
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
