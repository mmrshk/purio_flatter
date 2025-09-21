import '/components/first_question_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'continue1st_question_model.dart';
export 'continue1st_question_model.dart';

class Continue1stQuestionWidget extends StatefulWidget {
  const Continue1stQuestionWidget({super.key});

  static String routeName = 'Continue1stQuestion';
  static String routePath = '/continue1stQuestion';

  @override
  State<Continue1stQuestionWidget> createState() =>
      _Continue1stQuestionWidgetState();
}

class _Continue1stQuestionWidgetState extends State<Continue1stQuestionWidget>
    with RouteAware {
  late Continue1stQuestionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Continue1stQuestionModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(Continue1stQuestionWidget oldWidget) {
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
                  onPressed: () async {
                    context.safePop();
                  },
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: const AlignmentDirectional(-1.0, -1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0.0, 51.0, 0.0, 23.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        23.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 15.0),
                                              child: Text(
                                                FFLocalizations.of(context).getText(
                                                  '6c55y8ef' /* 2 quick questions */,
                                                ),
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.black,
                                                      fontSize: 25.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context).getText(
                                                'mgmbqkym' /* *1: How do you choose your pro... */,
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w300,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(23.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 350.0,
                                    child: Form(
                                      key: _model.formKey,
                                      autovalidateMode: AutovalidateMode.disabled,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          wrapWithModel(
                                            model: _model.firstQuestionModel1,
                                            updateCallback: () => safeSetState(() {}),
                                            child: Builder(builder: (_) {
                                              return DebugFlutterFlowModelContext(
                                                rootModel: _model.rootModel,
                                                child: FirstQuestionWidget(
                                                  level: 'Explorer',
                                                  description:
                                                      'I pick what looks good or feels \nfamiliar.',
                                                  btnColor: _model.selectedBtnColor,
                                                ),
                                              );
                                            }),
                                          ),
                                          wrapWithModel(
                                            model: _model.firstQuestionModel2,
                                            updateCallback: () => safeSetState(() {}),
                                            child: Builder(builder: (_) {
                                              return DebugFlutterFlowModelContext(
                                                rootModel: _model.rootModel,
                                                child: FirstQuestionWidget(
                                                  level: 'Label Curios',
                                                  description:
                                                      'I sometimes check labels for \nhealthier choices.',
                                                ),
                                              );
                                            }),
                                          ),
                                          wrapWithModel(
                                            model: _model.firstQuestionModel3,
                                            updateCallback: () => safeSetState(() {}),
                                            child: Builder(builder: (_) {
                                              return DebugFlutterFlowModelContext(
                                                rootModel: _model.rootModel,
                                                child: FirstQuestionWidget(
                                                  level: 'Label Pro',
                                                  description:
                                                      'I analyze ingredients to choose \nthe best products.',
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
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
              Stack(
                alignment: const AlignmentDirectional(0.0, 1.0),
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 80.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          Continue2ndQuestionWidget.routeName);
                                    },
                                    child: Container(
                                      width: 305.0,
                                      height: 43.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF40E0D0),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            26.0, 0.0, 26.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'o63c9mmp' /* Continue  */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
