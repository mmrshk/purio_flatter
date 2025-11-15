import 'dart:ui' as ui;
import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
import '/flutter_flow/shimmer_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
import '/scan/scan_screen.dart';
import '/sign_up_windows/profile/additives_screen/additives_screen_widget.dart';
import '/sign_up_windows/profile/ingredients_screen/ingredients_screen_widget.dart';
import '/services/popular_products_service.dart';
import '/services/health_score_service.dart';
import '/services/user_stats_service.dart';
export 'home_screen_model.dart';

class ExploreCard extends StatefulWidget {
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
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _shadowAnimation = Tween<double>(begin: 0.08, end: 0.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 160,
              height: 170,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_shadowAnimation.value),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
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
                    widget.subtitle,
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
        },
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
  final int? healthScore;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onTap,
    required this.isLoading,
    required this.loadingBuilder,
    this.healthScore,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Shimmer(
              linearGradient: shimmerGradient,
              child: ShimmerLoading(
                isLoading: isLoading,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    imageUrl,
                    width: 116,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: loadingBuilder,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 116,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            'assets/images/ImagePlaceholderIcon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Safety score indicator
            Builder(
              builder: (context) {
                if (healthScore != null) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: HealthScoreService.getHealthScoreColor(healthScore!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${FFLocalizations.of(context).getText('safety_label')}: $healthScore/100',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
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
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
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
  final ScrollController _scrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  Set<int> _loadedImageIndexes = {};
  final Map<int, DateTime> _imageLoadStartTimes = {};
  final int _minSkeletonMillis = 1200;

  // User stats
  int _scanCount = 0;
  int _streak = 0;

  // Carousel state
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeScreenModel());

    // Add listener to horizontal scroll controller
    _horizontalScrollController.addListener(_onHorizontalScroll);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _fetchUserData();
      await _fetchProducts();
      await _fetchUserStats();
    });
  }

  void _onHorizontalScroll() {
    if (_horizontalScrollController.hasClients) {
      final scrollOffset = _horizontalScrollController.offset;
      final cardWidth = 160.0 + 12.0; // Card width + spacing
      final newIndex = (scrollOffset / cardWidth).round();

      if (newIndex != _currentCarouselIndex && newIndex >= 0) {
        setState(() {
          _currentCarouselIndex = newIndex;
        });
      }
    }
  }

  Future<void> _fetchUserData() async {
    try {
      _model.userDataResponse = await UserDataTable().queryRows(
        queryFn: (q) => q.eq(
          'user_id',
          currentUserUid,
        ),
      );

      if ((_model.userDataResponse?.isNotEmpty ?? false) == true) {
        final userData = _model.userDataResponse!.first;

        // Check if user has complete profile (has type and expectations)
        // Also check that expectations doesn't contain "null" text (from old buggy saves)
        final hasValidType = userData.type?.isNotEmpty == true;
        final hasValidExpectations = userData.expectations?.isNotEmpty == true &&
                                     !userData.expectations!.toLowerCase().contains('null');

        if (hasValidType && hasValidExpectations) {
          // User has complete profile, proceed to home screen
          FFAppState().firstName = userData.firstName ?? '';
          safeSetState(() {});
          FFAppState().lastName = userData.lastName ?? '';
          safeSetState(() {});
        } else {
          // User data exists but is incomplete, redirect to onboarding
          print('⚠️ User profile incomplete - type: $hasValidType, expectations: $hasValidExpectations');
          _redirectToOnboarding();
        }
      } else {
        // No user data found - this could be a new user or an existing user without profile data
        // Redirect to onboarding to complete the profile
        print('⚠️ No user data found, redirecting to onboarding');
        _redirectToOnboarding();
      }
    } catch (e) {
      // Error fetching user data
    } finally {
      _model.isLoading = false;
      safeSetState(() {});
    }
  }

  void _redirectToOnboarding() {
    // Always go to account details first, but Google users will have pre-filled data
    context.goNamed(ContinueAccountDetailsWidget.routeName);
  }

  Future<void> _fetchProducts() async {
    try {
      // Use popular products service to get globally popular products
      final products = await PopularProductsService.instance.getPopularProducts(limit: 5);
      _model.randomProducts = products;
    } catch (e) {
      print('Error fetching popular products: $e');
      _model.randomProducts = [];
    }
    safeSetState(() {});
  }

  Future<void> _fetchUserStats() async {
    try {
      final stats = await UserStatsService.instance.getUserStats();
      setState(() {
        _scanCount = stats['scanCount'] ?? 0;
        _streak = stats['streak'] ?? 0;
      });
    } catch (e) {
      print('Error fetching user stats: $e');
      setState(() {
        _scanCount = 0;
        _streak = 0;
      });
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _scrollController.dispose();
    _horizontalScrollController.dispose();
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
      _fetchUserStats();
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
                child: CustomPaint(
                  painter: GeometricPatternPainter(),
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
                        controller: _scrollController,
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
                                    // Left side: Avatar + Name + Settings
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Clean avatar
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
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF50B2B2),
                                                  Color(0xFF40A5A5),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF50B2B2).withOpacity(0.3),
                                                  blurRadius: 8,
                                                  spreadRadius: 2,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                              border: Border.all(
                                                color: Colors.white.withOpacity(0.3),
                                                width: 2,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${FFAppState().firstName.isNotEmpty ? FFAppState().firstName[0].toUpperCase() : ''}${FFAppState().lastName.isNotEmpty ? FFAppState().lastName[0].toUpperCase() : ''}',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        // User name display
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
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
                                      ],
                                    ),
                                    // User stats dashboard
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.qr_code_scanner,
                                              color: const Color(0xFF50B2B2),
                                              size: 14,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${_scanCount} ${FFLocalizations.of(context).getText('home_scans_label' /* scans */)}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF50B2B2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              color: const Color(0xFFFF6B35),
                                              size: 14,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${_streak} ${FFLocalizations.of(context).getText('home_day_streak' /* day streak */)}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFFFF6B35),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 0.0, 23.0, 29.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF50B2B2).withOpacity(0.1),
                                        const Color(0xFF50B2B2).withOpacity(0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF50B2B2).withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.explore,
                                            color: const Color(0xFF50B2B2),
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF50B2B2).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getText('home_discover' /* Discover */),
                                          style: TextStyle(
                                            color: const Color(0xFF50B2B2),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                          context.pushNamed(SearchWidget.routeName);
                                        },
                                      ),
                                      ExploreCard(
                                        color: const Color(0xFFE6EDF8),
                                        imagePath: 'assets/images/Additivies.png',
                                        title: FFLocalizations.of(context).getText('ba1vcuow' /* Additives */),
                                        subtitle: FFLocalizations.of(context).getText('nsdcps41' /* Learn what's inside. */),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const AdditivesScreen()),
                                          );
                                        },
                                      ),
                                      ExploreCard(
                                        color: const Color(0xFFFFE6E8),
                                        imagePath: 'assets/images/Bad_Ingredients.png',
                                        title: FFLocalizations.of(context).getText('9bs48st0' /* Ingredients */),
                                        subtitle: FFLocalizations.of(context).getText('ga6umnbw' /* Spot harmful items. */),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const IngredientsScreen()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Section divider
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(23.0, 20.0, 23.0, 10.0),
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        const Color(0xFF50B2B2).withOpacity(0.2),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 0.5, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 20.0, 23.0, 20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(PopularScansWidget.routeName);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFF50B2B2).withOpacity(0.1),
                                          const Color(0xFF50B2B2).withOpacity(0.05),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFF50B2B2).withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.trending_up,
                                              color: const Color(0xFF50B2B2),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    23.0, 0.0, 0.0, 0.0),
                                child: SingleChildScrollView(
                                  controller: _horizontalScrollController,
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 23, bottom: 10),
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
                                                    name: product.name,
                                                    healthScore: product.healthScore,
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
                              // Carousel indicators
                              if (_model.randomProducts != null && _model.randomProducts!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      _model.randomProducts!.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          final cardWidth = 160.0 + 12.0; // Card width + spacing
                                          _horizontalScrollController.animateTo(
                                            index * cardWidth,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 3),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index == _currentCarouselIndex
                                                ? const Color(0xFF50B2B2)
                                                : const Color(0xFF50B2B2).withOpacity(0.3),
                                          ),
                                        ),
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
                    child: wrapWithModel(
                      model: _model.navbarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: Builder(builder: (_) {
                        return DebugFlutterFlowModelContext(
                          rootModel: _model.rootModel,
                          child: NavbarWidget(scrollController: _scrollController),
                        );
                      }),
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

class GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF50B2B2).withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Draw subtle geometric pattern
    const double spacing = 60.0;
    const double radius = 2.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        // Offset every other row for a more interesting pattern
        final offsetX = (y / spacing).floor() % 2 == 0 ? x : x + spacing / 2;

        if (offsetX < size.width && y < size.height) {
          canvas.drawCircle(
            Offset(offsetX, y),
            radius,
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
