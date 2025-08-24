import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scoring_method_model.dart';
export 'scoring_method_model.dart';

class ScoringMethodWidget extends StatefulWidget {
  const ScoringMethodWidget({super.key});

  static String routeName = 'ScoringMethod';
  static String routePath = '/scoringMethod';

  @override
  State<ScoringMethodWidget> createState() => _ScoringMethodWidgetState();
}

class _ScoringMethodWidgetState extends State<ScoringMethodWidget>
    with RouteAware {
  late ScoringMethodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScoringMethodModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _model.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScoringMethodWidget oldWidget) {
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      FFLocalizations.of(context).getText('scoring_method_title'),
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                            ),
                            color: Colors.black,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 45.0),
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
            padding: const EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE6F7F5), Colors.white],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(23.0, 0.0, 23.0, 0.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 24.0),
                                child: Text(
                                  FFLocalizations.of(context).getText('how_we_score_products'),
                                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                        ),
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                      ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildScoreSection(
                                        FFLocalizations.of(context).getText('overall_safety_score'),
                                        FFLocalizations.of(context).getText('overall_safety_description'),
                                        Icons.security,
                                        const Color(0xFF40A5A5),
                                      ),
                                      const SizedBox(height: 24.0),
                                      _buildScoreSection(
                                        FFLocalizations.of(context).getText('nutritional_quality'),
                                        FFLocalizations.of(context).getText('nutritional_quality_description'),
                                        Icons.monitor_heart,
                                        const Color(0xFF2ECC71),
                                      ),
                                      const SizedBox(height: 24.0),
                                      _buildScoreSection(
                                        FFLocalizations.of(context).getText('additives_ingredients'),
                                        FFLocalizations.of(context).getText('additives_ingredients_description'),
                                        Icons.science,
                                        const Color(0xFFFFA500),
                                      ),
                                      const SizedBox(height: 24.0),
                                      _buildScoreSection(
                                        FFLocalizations.of(context).getText('processing_level'),
                                        FFLocalizations.of(context).getText('processing_level_description'),
                                        Icons.factory,
                                        const Color(0xFFE74C3C),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText('score_interpretation'),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                              ),
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      _buildScoreRange('90-100', FFLocalizations.of(context).getText('excellent'), FFLocalizations.of(context).getText('very_healthy_choice'), const Color(0xFF2ECC71)),
                                      _buildScoreRange('70-89', FFLocalizations.of(context).getText('good'), FFLocalizations.of(context).getText('generally_healthy_option'), const Color(0xFF40A5A5)),
                                      _buildScoreRange('50-69', FFLocalizations.of(context).getText('fair'), FFLocalizations.of(context).getText('moderate_health_impact'), const Color(0xFFFFA500)),
                                      _buildScoreRange('0-49', FFLocalizations.of(context).getText('poor'), FFLocalizations.of(context).getText('consider_alternatives'), const Color(0xFFE74C3C)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText('our_methodology'),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                              ),
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Text(
                                        FFLocalizations.of(context).getText('methodology_description'),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                              ),
                                              color: const Color(0xFF6A7F98),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                            ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText('scoring_system_intro'),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                                  color: const Color(0xFF40A5A5),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '• ${FFLocalizations.of(context).getText('nova_score_desc')}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.roboto(
                                                          fontWeight: FontWeight.normal,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: const Color(0xFF6A7F98),
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.normal,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  '• ${FFLocalizations.of(context).getText('nutri_score_desc')}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.roboto(
                                                          fontWeight: FontWeight.normal,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: const Color(0xFF6A7F98),
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.normal,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  '• ${FFLocalizations.of(context).getText('additives_score_desc')}',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.roboto(
                                                          fontWeight: FontWeight.normal,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: const Color(0xFF6A7F98),
                                                        fontSize: 13.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.normal,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12.0),
                                          Text(
                                            FFLocalizations.of(context).getText('scoring_formula_title'),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                                  color: const Color(0xFF40A5A5),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF8F9FA),
                                              borderRadius: BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: const Color(0xFFE9ECEF),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Text(
                                              FFLocalizations.of(context).getText('scoring_formula'),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                                    color: const Color(0xFF495057),
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                            ),
                                          ),
                                          const SizedBox(height: 12.0),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFF3CD),
                                              borderRadius: BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: const Color(0xFFFFEAA7),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Text(
                                              FFLocalizations.of(context).getText('safety_rule'),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                                    color: const Color(0xFF856404),
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ],
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreSection(String title, String description, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20.0,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: Colors.black,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: const Color(0xFF6A7F98),
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreRange(String range, String label, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      range,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: Colors.black,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      label,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: color,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: const Color(0xFF6A7F98),
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
