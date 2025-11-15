import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/backend/supabase/database/tables/user_data.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'delete_account_pop_up_model.dart';
export 'delete_account_pop_up_model.dart';

class DeleteAccountPopUpWidget extends StatefulWidget {
  const DeleteAccountPopUpWidget({super.key});

  @override
  State<DeleteAccountPopUpWidget> createState() =>
      _DeleteAccountPopUpWidgetState();
}

class _DeleteAccountPopUpWidgetState extends State<DeleteAccountPopUpWidget>
    with RouteAware {
  late DeleteAccountPopUpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteAccountPopUpModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.maybeDispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(DeleteAccountPopUpWidget oldWidget) {
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

  Future<void> _requestAccountDeletion() async {
    final userId = currentUserUid;
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            FFLocalizations.of(context).getText('delete_request_error'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final userRows = await UserDataTable().queryRows(
        queryFn: (q) => q.eq('user_id', userId).limit(1),
      );
      final userRow = userRows.isNotEmpty ? userRows.first : null;
      if (userRow == null) {
        throw Exception('No user profile found for current user.');
      }

      await SupaFlow.client.from('account_deletion_requests').insert({
        'user_id': userRow.id,
        'email': currentUserEmail,
        'requested_at': DateTime.now().toUtc().toIso8601String(),
      });

      Navigator.of(context).pop(); // loading
      Navigator.of(context).pop(); // popup

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            FFLocalizations.of(context).getText('delete_request_success'),
          ),
        ),
      );

      await authManager.signOut();
      context.goNamed(SingUpLogInWidget.routeName);
    } catch (e) {
      Navigator.of(context).pop();
      debugPrint('❌ Account deletion request failed: $e');
      final friendlyMessage =
          (e is PostgrestException && e.message.isNotEmpty) ? e.message : null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            friendlyMessage ??
                FFLocalizations.of(context).getText('delete_request_error'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);

    return Container(
      width: 341.0,
      height: 250.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 19.0, 0.0, 19.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'sup7de9p' /* Are You Sure? */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: Colors.black,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 19.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'qp8tp30w' /* All your data will be gone. S... */
                  ,
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: Colors.black,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
            child: FFButtonWidget(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: FFLocalizations.of(context).getText(
                'rh4mxwuv' /* Keep My Account */,
              ),
              options: FFButtonOptions(
                width: 185.0,
                height: 45.0,
                padding: const EdgeInsets.all(0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: const Color(0xFF40E0D0),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: Colors.white,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 19.0),
            child: InkWell(
              onTap: _requestAccountDeletion,
              child: Text(
                FFLocalizations.of(context).getText(
                  'h0ea7x3j' /* Delete It Anyway */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: const Color(0xFF6A7F98),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
