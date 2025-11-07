import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'second_question_model.dart';
export 'second_question_model.dart';

class SecondQuestionWidget extends StatefulWidget {
  const SecondQuestionWidget({
    super.key,
    this.image,
    required this.description,
    required this.expectation,
    this.hasValidationError = false,
  });

  final String? image;
  final String? description;
  final String? expectation;
  final bool hasValidationError;

  @override
  State<SecondQuestionWidget> createState() => _SecondQuestionWidgetState();
}

class _SecondQuestionWidgetState extends State<SecondQuestionWidget>
    with RouteAware {
  late SecondQuestionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SecondQuestionModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.maybeDispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(SecondQuestionWidget oldWidget) {
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

  String _getLocalizedExpectation(String? expectation) {
    if (expectation == null) return '';
    switch (expectation) {
      case 'Find':
        return FFLocalizations.of(context).getText('expectation_find');
      case 'Understand':
        return FFLocalizations.of(context).getText('expectation_understand');
      case 'Create':
        return FFLocalizations.of(context).getText('expectation_create');
      case 'Save':
        return FFLocalizations.of(context).getText('expectation_save');
      case 'Learn':
        return FFLocalizations.of(context).getText('expectation_learn');
      case 'Track':
        return FFLocalizations.of(context).getText('expectation_track');
      default:
        return expectation;
    }
  }

  String _getLocalizedExpectationDescription(String? expectation) {
    if (expectation == null) return '';
    switch (expectation) {
      case 'Find':
        return FFLocalizations.of(context).getText('expectation_find_desc');
      case 'Understand':
        return FFLocalizations.of(context).getText('expectation_understand_desc');
      case 'Create':
        return FFLocalizations.of(context).getText('expectation_create_desc');
      case 'Save':
        return FFLocalizations.of(context).getText('expectation_save_desc');
      case 'Learn':
        return FFLocalizations.of(context).getText('expectation_learn_desc');
      case 'Track':
        return FFLocalizations.of(context).getText('expectation_track_desc');
      default:
        return widget.description ?? '';
    }
  }

  String _getEmojiForExpectation(String? expectation) {
    switch (expectation) {
      case 'Find':
        return '🔍';
      case 'Understand':
        return '🏷️';
      case 'Create':
        return '🛒';
      case 'Save':
        return '⏰';
      case 'Learn':
        return '🌱';
      case 'Track':
        return '📊';
      default:
        return '🔍';
    }
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        FFAppState().expectation = widget.expectation!;
        _model.updatePage(() {});
        if (FFAppState().expectations.contains(FFAppState().expectation) ==
            false) {
          // Add item to expectations
          FFAppState().addToExpectations(FFAppState().expectation);
          safeSetState(() {});
        } else {
          // Remove item from expectation
          FFAppState().removeFromExpectations(FFAppState().expectation);
          safeSetState(() {});
        }
      },
      child: Container(
        width: 162.0,
        height: 140.0,
        decoration: BoxDecoration(
          color: FFAppState().expectations.contains(widget.expectation)
              ? const Color(0xFFE0F7F5) // Light teal background when selected
              : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: widget.hasValidationError
                ? Colors.red
                : FFAppState().expectations.contains(widget.expectation)
                    ? const Color(0xFF40E0D0) // Teal border when selected
                    : const Color(0xFFB0E0DC), // Lighter teal border when not selected
            width: FFAppState().expectations.contains(widget.expectation)
                ? 2.5 // Thicker border when selected
                : 1.0,
          ),
        ),
        child: Stack(
          alignment: const AlignmentDirectional(0.0, 0.0),
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _getEmojiForExpectation(widget.expectation),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _getLocalizedExpectation(widget.expectation),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: const Color(0xFF6A7F98),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        TextSpan(
                          text: _getLocalizedExpectationDescription(widget.expectation),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: const Color(0xFF6A7F98),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: const Color(0xFF6A7F98),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Align(
              alignment: const AlignmentDirectional(1.0, -1.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 8.0, 0.0),
                child: FFAppState().expectations.contains(widget.expectation)
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF40E0D0), // Teal checkmark when selected
                        size: 26.0,
                      )
                    : const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF474646),
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
