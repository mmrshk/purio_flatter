import '/auth/supabase_auth/auth_util.dart';
import '/components/delete_account_pop_up_widget.dart';
import '/components/settings_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_model.dart';
export 'edit_profile_model.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  static String routeName = 'EditProfile';
  static String routePath = '/editProfile';

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> with RouteAware {
  late EditProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(EditProfileWidget oldWidget) {
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
            onPressed: () {
              context.pop();
                  },
                ),
          title: Text(
                          FFLocalizations.of(context).getText(
                            'fh8utk4t' /* Edit Profile */,
                          ),
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
            padding: const EdgeInsetsDirectional.fromSTEB(33.0, 20.0, 33.0, 0.0),
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
                  InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        context.goNamedAuth(
                            SingUpLogInWidget.routeName, context.mounted);
                      },
                    child: wrapWithModel(
                      model: _model.settingsCardModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: Builder(builder: (_) {
                        return DebugFlutterFlowModelContext(
                          rootModel: _model.rootModel,
                          child: SettingsCardWidget(
                            icon: const Icon(
                              Icons.logout_sharp,
                                    color: Colors.white,
                              size: 28.0,
                                  ),
                            setting: FFLocalizations.of(context).getText(
                                      'c4vorr30' /* Sign Out */,
                                    ),
                            backgroundColor: const Color(0xFFFF6B6B), // Red for sign out
                          ),
                        );
                      }),
                    ),
                    ),
                  Builder(
                      builder: (context) => InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await showDialog(
                            barrierColor: const Color(0x3F525252),
                            barrierDismissible: true,
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: const AlignmentDirectional(0.0, 0.8)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.transparent,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Prevent closing when tapping on the popup content
                                        },
                                        child: const SizedBox(
                                          height: 250.0,
                                          width: 341.0,
                                          child: DeleteAccountPopUpWidget(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      child: wrapWithModel(
                        model: _model.settingsCardModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: Builder(builder: (_) {
                          return DebugFlutterFlowModelContext(
                            rootModel: _model.rootModel,
                            child: SettingsCardWidget(
                              icon: const Icon(
                                Icons.delete_sweep_outlined,
                                      color: Colors.white,
                                size: 28.0,
                                    ),
                              setting: FFLocalizations.of(context).getText(
                                        't9wjo91d' /* Delete Account */,
                                      ),
                              backgroundColor: const Color(0xFFFF4757), // Dark red for delete
                            ),
                          );
                        }),
                      ),
                    ),
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
