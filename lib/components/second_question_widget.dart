import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  });

  final String? image;
  final String? description;
  final String? expectation;

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color(0xFF40E0D0),
            width: FFAppState().expectations.contains(widget.expectation)
                ? 2.0
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    imageUrl: valueOrDefault<String>(
                      widget.image,
                      'data:image/png;base64,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',
                    ),
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.expectation,
                            'expectation ',
                          ),
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
                          text: valueOrDefault<String>(
                            widget.description,
                            'description ',
                          ),
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
            const Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 8.0, 0.0),
                child: Icon(
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
