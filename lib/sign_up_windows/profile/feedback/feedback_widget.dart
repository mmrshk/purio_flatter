import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/feedback_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'feedback_model.dart';
export 'feedback_model.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  static String routeName = 'Feedback';
  static String routePath = '/feedback';

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> with RouteAware {
  late FeedbackModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedbackModel());

    _model.textController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(FeedbackWidget oldWidget) {
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText('wvrb7mdi' /* Privacy Policy */),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'd96v3xf6' /* ISSUE, QUESTION OR SUGGESTION */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                                                 Expanded(
                           child: Container(
                             width: double.infinity,
                             decoration: BoxDecoration(
                               color: FlutterFlowTheme.of(context).secondaryBackground,
                               borderRadius: BorderRadius.circular(12),
                               border: Border.all(
                                 color: FlutterFlowTheme.of(context).alternate,
                                 width: 1,
                               ),
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(16),
                               child: TextFormField(
                                 controller: _model.textController,
                                 focusNode: _model.textFieldFocusNode,
                                 autofocus: false,
                                 obscureText: false,
                                 expands: true,
                                 textAlignVertical: TextAlignVertical.top,
                                 decoration: InputDecoration(
                                   isDense: false,
                                   contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                   labelStyle: FlutterFlowTheme.of(context)
                                       .labelMedium
                                       .override(
                                         font: GoogleFonts.roboto(
                                           fontWeight: FontWeight.w400,
                                           fontStyle: FlutterFlowTheme.of(context)
                                               .labelMedium
                                               .fontStyle,
                                         ),
                                         fontSize: 14.0,
                                         letterSpacing: 0.0,
                                         fontWeight: FontWeight.w400,
                                         fontStyle: FlutterFlowTheme.of(context)
                                             .labelMedium
                                             .fontStyle,
                                       ),
                                   hintText: FFLocalizations.of(context).getText(
                                     'pkpdfk4m' /* Your Message to Our Team */,
                                   ),
                                   hintStyle: FlutterFlowTheme.of(context)
                                       .labelMedium
                                       .override(
                                         font: GoogleFonts.roboto(
                                           fontWeight: FlutterFlowTheme.of(context)
                                               .labelMedium
                                               .fontWeight,
                                           fontStyle: FlutterFlowTheme.of(context)
                                               .labelMedium
                                               .fontStyle,
                                         ),
                                         letterSpacing: 0.0,
                                         fontWeight: FlutterFlowTheme.of(context)
                                             .labelMedium
                                             .fontWeight,
                                         fontStyle: FlutterFlowTheme.of(context)
                                             .labelMedium
                                             .fontStyle,
                                       ),
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: FlutterFlowTheme.of(context).alternate,
                                       width: 2,
                                     ),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: FlutterFlowTheme.of(context).primary,
                                       width: 2,
                                     ),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   errorBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: FlutterFlowTheme.of(context).error,
                                       width: 2,
                                     ),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   focusedErrorBorder: OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: FlutterFlowTheme.of(context).error,
                                       width: 2,
                                     ),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   filled: true,
                                   fillColor: FlutterFlowTheme.of(context)
                                       .secondaryBackground,
                                 ),
                                 style: FlutterFlowTheme.of(context)
                                     .bodyMedium
                                     .override(
                                       font: GoogleFonts.roboto(
                                         fontWeight: FlutterFlowTheme.of(context)
                                             .bodyMedium
                                             .fontWeight,
                                         fontStyle: FlutterFlowTheme.of(context)
                                             .bodyMedium
                                             .fontStyle,
                                       ),
                                       letterSpacing: 0.0,
                                       fontWeight: FlutterFlowTheme.of(context)
                                           .bodyMedium
                                           .fontWeight,
                                       fontStyle: FlutterFlowTheme.of(context)
                                           .bodyMedium
                                           .fontStyle,
                                     ),
                                 maxLines: null,
                                 cursorColor:
                                     FlutterFlowTheme.of(context).primaryText,
                                 validator: _model.textControllerValidator
                                     .asValidator(context),
                               ),
                             ),
                           ),
                         ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: SizedBox(
                            width: double.infinity,
                                                         child: FFButtonWidget(
                               onPressed: () async {
                                 final feedbackText = _model.textController.text.trim();
                                 if (feedbackText.isEmpty) {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                       content: Text(FFLocalizations.of(context).getText('feedback_enter_message')),
                                       backgroundColor: FlutterFlowTheme.of(context).error,
                                     ),
                                   );
                                   return;
                                 }

                                 // Show loading state
                                 setState(() {
                                   _isLoading = true;
                                 });

                                 final success = await FeedbackService.saveFeedback(feedbackText);

                                 // Hide loading state
                                 setState(() {
                                   _isLoading = false;
                                 });

                                 if (success) {
                                   // Clear the text field
                                   _model.textController?.clear();
                                   
                                   // Show success message
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                       content: Text(FFLocalizations.of(context).getText('feedback_success')),
                                       backgroundColor: FlutterFlowTheme.of(context).primary,
                                     ),
                                   );
                                   
                                   // Navigate back
                                   context.safePop();
                                 } else {
                                   // Show error message
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                       content: Text(FFLocalizations.of(context).getText('feedback_error')),
                                       backgroundColor: FlutterFlowTheme.of(context).error,
                                     ),
                                   );
                                 }
                               },
                                                             text: _isLoading 
                                   ? FFLocalizations.of(context).getText('feedback_sending')
                                   : FFLocalizations.of(context).getText('fxp8nvjw' /* Send */),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 48.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
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
  }
}
