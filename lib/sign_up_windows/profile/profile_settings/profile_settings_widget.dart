import '/components/navbar_widget.dart';
import '/components/settings_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    context.pop();
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
                            'pjqxy9ew' /* Profile Settings */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
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
          child: Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 23.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    alignment: const AlignmentDirectional(0.0, 0.95),
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 120.0),
                          child: SingleChildScrollView(
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
                                                  decoration: const BoxDecoration(),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.0),
                                                    child: Image.asset(
                                                      'assets/images/ProfileImage.png',
                                                      width: 140.0,
                                                      height: 140.0,
                                                      fit: BoxFit.cover,
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
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'pjqxy9ew' /* Shambhavi Mishra */,
                                              ),
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
                                            FFLocalizations.of(context).getText(
                                              'gt9wxaso' /* mishra@gmail.com */,
                                            ),
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
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
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
                                                  0.0, 0.0, 0.0, 200.0),
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
                                                      child: const SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons.person_outlined,
                                                          color:
                                                              Color(0xFF40A5A5),
                                                          size: 28.0,
                                                        ),
                                                        setting: 'Edit Profile',
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
                                                      child: const SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .record_voice_over_outlined,
                                                          color:
                                                              Color(0xFF40A5A5),
                                                          size: 28.0,
                                                        ),
                                                        setting: 'Feedback',
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              wrapWithModel(
                                                model:
                                                    _model.settingsCardModel3,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: Builder(builder: (_) {
                                                  return DebugFlutterFlowModelContext(
                                                    rootModel: _model.rootModel,
                                                    child: const SettingsCardWidget(
                                                      icon: Icon(
                                                        Icons
                                                            .handshake_outlined,
                                                        color:
                                                            Color(0xFF40A5A5),
                                                        size: 28.0,
                                                      ),
                                                      setting:
                                                          'Invite a friend',
                                                    ),
                                                  );
                                                }),
                                              ),
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
                                                      child: const SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .lock_open_outlined,
                                                          color:
                                                              Color(0xFF40A5A5),
                                                          size: 28.0,
                                                        ),
                                                        setting:
                                                            'Privacy Policy',
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
                                                      child: const SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .article_outlined,
                                                          color:
                                                              Color(0xFF40A5A5),
                                                          size: 28.0,
                                                        ),
                                                        setting: 'Terms of Use',
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
                                                      NotificationsWidget
                                                          .routeName);
                                                },
                                                child: wrapWithModel(
                                                  model:
                                                      _model.settingsCardModel6,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: Builder(builder: (_) {
                                                    return DebugFlutterFlowModelContext(
                                                      rootModel:
                                                          _model.rootModel,
                                                      child: const SettingsCardWidget(
                                                        icon: Icon(
                                                          Icons
                                                              .notifications_outlined,
                                                          color:
                                                              Color(0xFF40A5A5),
                                                          size: 28.0,
                                                        ),
                                                        setting:
                                                            'Notifications',
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              wrapWithModel(
                                                model:
                                                    _model.settingsCardModel7,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: Builder(builder: (_) {
                                                  return DebugFlutterFlowModelContext(
                                                    rootModel: _model.rootModel,
                                                    child: const SettingsCardWidget(
                                                      icon: Icon(
                                                        Icons
                                                            .question_mark_outlined,
                                                        color:
                                                            Color(0xFF40A5A5),
                                                        size: 28.0,
                                                      ),
                                                      setting: 'FAQ',
                                                    ),
                                                  );
                                                }),
                                              ),
                                              wrapWithModel(
                                                model:
                                                    _model.settingsCardModel8,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: Builder(builder: (_) {
                                                  return DebugFlutterFlowModelContext(
                                                    rootModel: _model.rootModel,
                                                    child: const SettingsCardWidget(
                                                      icon: Icon(
                                                        Icons
                                                            .star_border_purple500_outlined,
                                                        color:
                                                            Color(0xFF40A5A5),
                                                        size: 28.0,
                                                      ),
                                                      setting: 'Subscription',
                                                    ),
                                                  );
                                                }),
                                              ),
                                              const Divider(
                                                thickness: 2.0,
                                                color: Color(0xFFDBD8D8),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 30.0, 0.0, 43.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'y2pb74w6' /* Follow Us */,
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
                                                        color: Colors.black,
                                                        fontSize: 24.0,
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
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  FlutterFlowIconButton(
                                                    borderRadius: 8.0,
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons
                                                          .instagram,
                                                      color: Colors.black,
                                                      size: 40.0,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                                  FlutterFlowIconButton(
                                                    borderRadius: 8.0,
                                                    icon: const Icon(
                                                      Icons.facebook_sharp,
                                                      color: Colors.black,
                                                      size: 40.0,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                                  FlutterFlowIconButton(
                                                    borderRadius: 8.0,
                                                    icon: const Icon(
                                                      Icons.tiktok,
                                                      color: Color(0xFF090909),
                                                      size: 40.0,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                                                child: SizedBox(),
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
                      ),
                      wrapWithModel(
                        model: _model.navbarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: Builder(builder: (_) {
                          return DebugFlutterFlowModelContext(
                            rootModel: _model.rootModel,
                            child: const NavbarWidget(),
                          );
                        }),
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
