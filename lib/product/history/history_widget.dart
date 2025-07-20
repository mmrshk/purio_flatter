import '/components/navbar_widget.dart';
import '/components/product_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/shimmer_util.dart';
import '/backend/supabase/supabase.dart';
import '/services/history_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryModel());
    _loadHistoryProducts();
  }

  Future<void> _loadHistoryProducts() async {
    try {
      final products = await HistoryService.getUserHistory(limit: 10);
      
      if (mounted) {
        setState(() {
          _model.historyProducts = products;
        });
      }
    } catch (e) {
      print('Error loading history products: $e');
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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 300.0,
                    height: 60.0,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'ymharo6a' /* History */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
              ],
            ),
            actions: const [],
            centerTitle: true,
            elevation: 1.0,
          ),
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
                              'Recent',
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
                              'Favorites',
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
                        if (_model.historyProducts.isEmpty) ...[
                          Text(
                            'No recents yet',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Your recently viewed products will appear here',
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
                                    padding: const EdgeInsets.only(bottom: 10.0),
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
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ShimmerLoading(
                                                isLoading: false,
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
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: ShimmerLoading(
                                                  isLoading: false,
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
                                            ],
                                          ),
                                        ),
                                      ),
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
                        Text(
                          'No favorites yet',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your favorite products will appear here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
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
