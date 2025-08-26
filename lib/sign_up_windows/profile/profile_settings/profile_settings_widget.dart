import '/components/settings_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/auth/supabase_auth/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_settings_model.dart';
export 'profile_settings_model.dart';

class ProfileSettingsWidget extends StatefulWidget {
  const ProfileSettingsWidget({super.key});

  static String routeName = 'ProfileSettings';
  static String routePath = '/profileSettings';

  @override
  State<ProfileSettingsWidget> createState() => _ProfileSettingsWidgetState();
}

class _ProfileSettingsWidgetState extends State<ProfileSettingsWidget>
    with RouteAware {
  late ProfileSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoadingSocial = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSettingsModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(ProfileSettingsWidget oldWidget) {
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

  Future<void> _launchURL(String url) async {
    if (_isLoadingSocial) return; // Prevent multiple taps
    
    setState(() {
      _isLoadingSocial = true;
    });
    
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open $url'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening link: $e'),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingSocial = false;
        });
      }
    }
  }

  Widget _buildSocialButton({
    required Widget icon,
    required Color backgroundColor,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
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
        backgroundColor: Colors.white,
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
                  onPressed: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      '${FFAppState().firstName.isNotEmpty ? FFAppState().firstName : ''} ${FFAppState().lastName.isNotEmpty ? FFAppState().lastName : ''}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle
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
                  ),
                ),
                const SizedBox(width: 45.0), // Balance the back button
              ],
            ),
            actions: const [],
            centerTitle: true,
            elevation: 1.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 23.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      alignment: const AlignmentDirectional(0.0, 0.95),
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 34.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 19.0),
                                            child: Stack(
                                              alignment: const AlignmentDirectional(
                                                  0.7, 1.0),
                                              children: [
                                                Container(
                                                  width: 140.0,
                                                  height: 140.0,
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
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${FFAppState().firstName.isNotEmpty ? FFAppState().firstName[0].toUpperCase() : ''}${FFAppState().lastName.isNotEmpty ? FFAppState().lastName[0].toUpperCase() : ''}',
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 48.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/PremiumIcon.png',
                                                    width: 25.0,
                                                    height: 25.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 9.0),
                                            child: Text(
                                              '${FFAppState().firstName} ${FFAppState().lastName}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.signika(
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
                                                        color: Colors.black,
                                                        fontSize: 24.0,
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
                                          ),
                                          Text(
                                            currentUserEmail,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.signika(
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
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      33.0, 20.0, 33.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      EditProfileWidget
                                                          .routeName);
                                                },
                                                child: wrapWithModel(
                                                  model:
                                                      _model.settingsCardModel1,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: Builder(builder: (_) {
                                                    return DebugFlutterFlowModelContext(
                                                      rootModel:
                                                          _model.rootModel,
                                                      child: SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons.person_outlined,
                                                          color: Colors.white,
                                                          size: 28.0,
                                                        ),
                                                        setting: FFLocalizations.of(context).getText(
                                                          'fh8utk4t' /* Edit Profile */,
                                                        ),
                                                        backgroundColor: const Color(0xFF4CAF50), // Green for profile
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      FeedbackWidget.routeName);
                                                },
                                                child: wrapWithModel(
                                                  model:
                                                      _model.settingsCardModel2,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: Builder(builder: (_) {
                                                    return DebugFlutterFlowModelContext(
                                                      rootModel:
                                                          _model.rootModel,
                                                      child: SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .record_voice_over_outlined,
                                                          color: Colors.white,
                                                          size: 28.0,
                                                        ),
                                                        setting: FFLocalizations.of(context).getText(
                                                          'feedback' /* Feedback */,
                                                        ),
                                                        backgroundColor: const Color(0xFFFF9800), // Orange for feedback
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              // wrapWithModel(
                                              //   model:
                                              //       _model.settingsCardModel3,
                                              //   updateCallback: () =>
                                              //       safeSetState(() {}),
                                              //   child: Builder(builder: (_) {
                                              //     return DebugFlutterFlowModelContext(
                                              //       rootModel: _model.rootModel,
                                              //       child: const SettingsCardWidget(
                                              //         icon: Icon(
                                              //           Icons
                                              //               .handshake_outlined,
                                              //           color:
                                              //               Color(0xFF40A5A5),
                                              //           size: 28.0,
                                              //         ),
                                              //         setting:
                                              //             'Invite a friend',
                                              //       ),
                                              //     );
                                              //   }),
                                              // ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      PrivacyPolicyWidget
                                                          .routeName);
                                                },
                                                child: wrapWithModel(
                                                  model:
                                                      _model.settingsCardModel4,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: Builder(builder: (_) {
                                                    return DebugFlutterFlowModelContext(
                                                      rootModel:
                                                          _model.rootModel,
                                                      child: SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .lock_open_outlined,
                                                          color: Colors.white,
                                                          size: 28.0,
                                                        ),
                                                        setting: FFLocalizations.of(context).getText(
                                                          'hi6tahx5' /* Privacy Policy */,
                                                        ),
                                                        backgroundColor: const Color(0xFF2196F3), // Blue for privacy
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      TermsOfUseWidget
                                                          .routeName);
                                                },
                                                child: wrapWithModel(
                                                  model:
                                                      _model.settingsCardModel5,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: Builder(builder: (_) {
                                                    return DebugFlutterFlowModelContext(
                                                      rootModel:
                                                          _model.rootModel,
                                                      child: SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .article_outlined,
                                                          color: Colors.white,
                                                          size: 28.0,
                                                        ),
                                                        setting: FFLocalizations.of(context).getText(
                                                          '7m87t0no' /* Terms of Use */,
                                                        ),
                                                        backgroundColor: const Color(0xFF9C27B0), // Purple for terms
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              // InkWell(
                                              //   splashColor: Colors.transparent,
                                              //   focusColor: Colors.transparent,
                                              //   hoverColor: Colors.transparent,
                                              //   highlightColor:
                                              //       Colors.transparent,
                                              //   onTap: () async {
                                              //     context.pushNamed(
                                              //         NotificationsWidget
                                              //             .routeName);
                                              //   },
                                              //   child: wrapWithModel(
                                              //     model:
                                              //         _model.settingsCardModel6,
                                              //     updateCallback: () =>
                                              //         safeSetState(() {}),
                                              //     child: Builder(builder: (_) {
                                              //       return DebugFlutterFlowModelContext(
                                              //         rootModel:
                                              //             _model.rootModel,
                                              //         child: SettingsCardWidget(
                                              //           icon: Icon(
                                              //             Icons
                                              //                 .notifications_outlined,
                                              //             color:
                                              //                 Color(0xFF40A5A5),
                                              //             size: 28.0,
                                              //           ),
                                              //           setting: FFLocalizations.of(context).getText(
                                              //             'se2g3ybz' /* Notifications */,
                                              //           ),
                                              //         ),
                                              //       );
                                              //     }),
                                              //   ),
                                              // ),
                                              // wrapWithModel(
                                              //   model:
                                              //       _model.settingsCardModel7,
                                              //   updateCallback: () =>
                                              //       safeSetState(() {}),
                                              //   child: Builder(builder: (_) {
                                              //     return DebugFlutterFlowModelContext(
                                              //       rootModel: _model.rootModel,
                                              //       child: SettingsCardWidget(
                                              //         icon: Icon(
                                              //           Icons
                                              //               .question_mark_outlined,
                                              //           color:
                                              //               Color(0xFF40A5A5),
                                              //           size: 28.0,
                                              //         ),
                                              //         setting: FFLocalizations.of(context).getText(
                                              //           'faq_key' /* FAQ */,
                                              //         ),
                                              //       ),
                                              //     );
                                              //   }),
                                              // ),
                                              // wrapWithModel(
                                              //   model:
                                              //       _model.settingsCardModel8,
                                              //   updateCallback: () =>
                                              //       safeSetState(() {}),
                                              //   child: Builder(builder: (_) {
                                              //     return DebugFlutterFlowModelContext(
                                              //       rootModel: _model.rootModel,
                                              //       child: SettingsCardWidget(
                                              //         icon: Icon(
                                              //           Icons
                                              //               .star_border_purple500_outlined,
                                              //           color:
                                              //               Color(0xFF40A5A5),
                                              //           size: 28.0,
                                              //         ),
                                              //         setting: FFLocalizations.of(context).getText(
                                              //           'subscription_key' /* Subscription */,
                                              //         ),
                                              //       ),
                                              //     );
                                              //   }),
                                              // ),
                                              const Divider(
                                                thickness: 2.0,
                                                color: Color(0xFFDBD8D8),
                                              ),
                                              // Follow Us Section
                                              Container(
                                                margin: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                                                padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                                      FlutterFlowTheme.of(context).primary.withOpacity(0.05),
                                                    ],
                                                  ),
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    // Title with icon
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.favorite,
                                                          color: FlutterFlowTheme.of(context).primary,
                                                          size: 24,
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          FFLocalizations.of(context).getText('y2pb74w6' /* Follow Us */),
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            font: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.bold,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.5,
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Stay connected with us!',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.roboto(
                                                          fontWeight: FontWeight.w400,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w400,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    // Social Media Icons
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        _buildSocialButton(
                                                          icon: _isLoadingSocial 
                                                              ? const SizedBox(
                                                                  width: 24,
                                                                  height: 24,
                                                                  child: CircularProgressIndicator(
                                                                    color: Colors.white,
                                                                    strokeWidth: 2,
                                                                  ),
                                                                )
                                                              : const FaIcon(
                                                                  FontAwesomeIcons.instagram,
                                                                  color: Colors.white,
                                                                  size: 24.0,
                                                                ),
                                                          backgroundColor: const Color(0xFFE4405F),
                                                          onPressed: _isLoadingSocial ? null : () {
                                                            _launchURL('https://www.instagram.com/purio.app');
                                                          },
                                                        ),
                                                        _buildSocialButton(
                                                          icon: const Icon(
                                                            Icons.facebook_sharp,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                          ),
                                                          backgroundColor: const Color(0xFF1877F2),
                                                          onPressed: () {
                                                            _launchURL('https://www.facebook.com/profile.php?id=61571037985756');
                                                          },
                                                        ),
                                                        _buildSocialButton(
                                                          icon: const Icon(
                                                            Icons.tiktok,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                          ),
                                                          backgroundColor: const Color(0xFF000000),
                                                          onPressed: () {
                                                            _launchURL('https://www.tiktok.com/@purio.app');
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                      ],
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
}
