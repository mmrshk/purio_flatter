import 'dart:ui' as ui;
import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
import '/scan/scan_screen.dart';
export 'home_screen_model.dart';

class ExploreCard extends StatelessWidget {
  final Color color;
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ExploreCard({
    super.key,
    required this.color,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 160,
        height: 170,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: const Color(0xFF555555),
              ),
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback onTap;
  final bool isLoading;
  final ImageLoadingBuilder loadingBuilder;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onTap,
    required this.isLoading,
    required this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 140,
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              linearGradient: _shimmerGradient,
              child: ShimmerLoading(
                isLoading: isLoading,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    imageUrl,
                    width: 116,
                    height: 116,
                    fit: BoxFit.cover,
                    loadingBuilder: loadingBuilder,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  static String routeName = 'HomeScreen';
  static String routePath = '/homeScreen';

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> with RouteAware {
  late HomeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Set<int> _loadedImageIndexes = {};
  final Map<int, DateTime> _imageLoadStartTimes = {};
  final int _minShimmerMillis = 1200;
  final int _minSkeletonMillis = 1200;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeScreenModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _fetchUserData();
      await _fetchProducts();
    });
  }

  Future<void> _fetchUserData() async {
    try {
      _model.userDataResponse = await UserDataTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'user_id',
          currentUserUid,
        ),
      );
      if ((_model.userDataResponse?.isNotEmpty ?? false) == true) {
        FFAppState().firstName = _model.userDataResponse?.firstOrNull?.firstName ?? '';
        safeSetState(() {});
        FFAppState().lastName = _model.userDataResponse?.firstOrNull?.lastName ?? '';
        safeSetState(() {});
      } else {
        context.goNamed(ContinueAccountDetailsWidget.routeName);
      }
    } finally {
      _model.isLoading = false;
      safeSetState(() {});
    }
  }

  Future<void> _fetchProducts() async {
    try {
      final result = await SupaFlow.client
          .from('Products')
          .select('id, name, image_front_url, category, created_at, updated_at, barcode, health_score, description, ingredients, supermarket_url, additional_images_urls, specifications, nutritional')
          .limit(20); // Fetch more than 5

      if (result.isNotEmpty) {
        List<ProductRow> allProducts = await ProductTable().queryRows(
          queryFn: (q) => q.select().limit(20),
        );
        allProducts.shuffle();
        _model.randomProducts = allProducts.take(5).toList();
      }
    } catch (e) {
      // Handle error silently
    }
    safeSetState(() {});
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(HomeScreenWidget oldWidget) {
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
      _fetchProducts();
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
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE6F7F5), Colors.white],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
              ),
            ),
            SafeArea(
              top: true,
              bottom: false,
              child: Stack(
                children: [
                  if (_model.isLoading)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF50B2B2)),
                        ),
                      ),
                    )
                  else
                    RefreshIndicator(
                      color: const Color(0xFF50B2B2),
                      onRefresh: () async {
                        setState(() {
                          _model.isLoading = true;
                          _loadedImageIndexes.clear();
                          _imageLoadStartTimes.clear();
                        });
                        await _fetchUserData();
                        await _fetchProducts();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 23.0, 0.0, 110.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 0.0, 23.0, 39.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                  ProfileSettingsWidget
                                                      .routeName);
                                            },
                                            child: Container(
                                              width: 47.0,
                                              height: 47.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                'assets/images/UserImage.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    30.0, 0.0, 0.0, 0.0),
                                            child: Wrap(
                                              spacing: 0.0,
                                              runSpacing: 0.0,
                                              alignment: WrapAlignment.start,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.start,
                                              direction: Axis.vertical,
                                              runAlignment: WrapAlignment.start,
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              clipBehavior: Clip.none,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'x9q2m7nf' /* Hello 👋🏻 */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            const Color(0xFF40A5A5),
                                                        fontSize: 22.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  '${FFAppState().firstName} ${FFAppState().lastName}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
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
                                                        color:
                                                            const Color(0xFF6A7F98),
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
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
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 78.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFAFAF),
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/Group.png',
                                              width: 20.0,
                                              height: 15.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
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
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 0.0, 0.0, 29.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'nhf9yk6j' /* Explore */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: const Color(0xFF50B2B2),
                                            fontSize: 18.0,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w800,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(23.0, 0.0, 23.0, 0.0),
                                  child: Wrap(
                                    spacing: 18.0,
                                    runSpacing: 18.0,
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.spaceBetween,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      ExploreCard(
                                        color: const Color(0xFFE0F8F6),
                                        imagePath: 'assets/images/Scan.png',
                                        title: FFLocalizations.of(context).getText('ujegbdrr' /* Scan */),
                                        subtitle: FFLocalizations.of(context).getText('8woh7s4n' /* Analyze products quickly. */),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const ScanScreen()),
                                          );
                                        },
                                      ),
                                      ExploreCard(
                                        color: const Color(0xFFFFF8D9),
                                        imagePath: 'assets/images/Search.png',
                                        title: FFLocalizations.of(context).getText('4dsnt882' /* Search */),
                                        subtitle: FFLocalizations.of(context).getText('6k9wcww2' /* Find product info fast. */),
                                        onTap: () {
                                          context.pushNamed('Search');
                                        },
                                      ),
                                      ExploreCard(
                                        color: const Color(0xFFE6EDF8),
                                        imagePath: 'assets/images/Additivies.png',
                                        title: FFLocalizations.of(context).getText('ba1vcuow' /* Additives */),
                                        subtitle: FFLocalizations.of(context).getText('nsdcps41' /* Learn what's inside. */),
                                        onTap: () {
                                          // TODO: Add navigation for Additives
                                        },
                                      ),
                                      ExploreCard(
                                        color: const Color(0xFFFFE6E8),
                                        imagePath: 'assets/images/Bad_Ingredients.png',
                                        title: FFLocalizations.of(context).getText('sg8ho7tf' /* Bad Ingredients */),
                                        subtitle: FFLocalizations.of(context).getText('ga6umnbw' /* Spot harmful items. */),
                                        onTap: () {
                                          // TODO: Add navigation for Bad Ingredients
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 29.0, 0.0, 29.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'hine2wdn' /* Popular scans */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: const Color(0xFF50B2B2),
                                            fontSize: 18.0,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w800,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 0.0, 0.0, 0.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 23, bottom: 23),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.randomProducts != null)
                                          ...(_model.randomProducts ?? []).asMap().entries.map((entry) {
                                            final index = entry.key;
                                            final product = entry.value;
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12),
                                                  child: ProductCard(
                                                    imageUrl: product.imageFrontUrl ?? 'https://picsum.photos/seed/895/600',
                                                    name: product.name ?? '',
                                                    isLoading: !_loadedImageIndexes.contains(index),
                                                    onTap: () {
                                                      context.pushNamed(
                                                        ProductDetailsWidget.routeName,
                                                        extra: <String, dynamic>{
                                                          'product': product,
                                                        },
                                                      );
                                                    },
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
                                                          return productImageSkeleton();
                                                        } else {
                                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                                            if (mounted) setState(() {
                                                              _loadedImageIndexes.add(index);
                                                            });
                                                          });
                                                          return child;
                                                        }
                                                      } else {
                                                        return productImageSkeleton();
                                                      }
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                              ],
                                            );
                                          }).toList(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SafeArea(
                      top: false,
                      bottom: true,
                      child: wrapWithModel(
                        model: _model.navbarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: Builder(builder: (_) {
                          return DebugFlutterFlowModelContext(
                            rootModel: _model.rootModel,
                            child: const NavbarWidget(),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Shimmer classes from Flutter docs ---
const _shimmerGradient = LinearGradient(
  colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({super.key, required this.linearGradient, this.child});

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
    colors: widget.linearGradient.colors,
    stops: widget.linearGradient.stops,
    begin: widget.linearGradient.begin,
    end: widget.linearGradient.end,
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});
  final double slidePercent;
  @override
  Matrix4? transform(Rect bounds, {ui.TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;
  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }
  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }
  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

Widget productImageSkeleton() {
  return Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(16.0),
    ),
  );
}

Widget productNameSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 80,
        height: 14,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(height: 6),
      Container(
        width: 50,
        height: 14,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
}
