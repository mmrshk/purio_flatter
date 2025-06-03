import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/second_question_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'continue2nd_question_model.dart';
export 'continue2nd_question_model.dart';

class Continue2ndQuestionWidget extends StatefulWidget {
  const Continue2ndQuestionWidget({super.key});

  static String routeName = 'Continue2ndQuestion';
  static String routePath = '/continue2ndQuestion';

  @override
  State<Continue2ndQuestionWidget> createState() =>
      _Continue2ndQuestionWidgetState();
}

class _Continue2ndQuestionWidgetState extends State<Continue2ndQuestionWidget>
    with RouteAware {
  late Continue2ndQuestionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Continue2ndQuestionModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(Continue2ndQuestionWidget oldWidget) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          'd0ty1i2e' /* 2 quick questions */,
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
                                        '49mr6z1h' /* *2: What do you want Purio to ... */,
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
                              child: Wrap(
                                spacing: 16.0,
                                runSpacing: 24.0,
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.spaceBetween,
                                verticalDirection: VerticalDirection.down,
                                clipBehavior: Clip.none,
                                children: [
                                  wrapWithModel(
                                    model: _model.secondQuestionModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Builder(builder: (_) {
                                      return DebugFlutterFlowModelContext(
                                        rootModel: _model.rootModel,
                                        child: const SecondQuestionWidget(
                                          description:
                                              ' healthier food options.',
                                          image:
                                              'data:image/png;base64,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',
                                          expectation: 'Find',
                                        ),
                                      );
                                    }),
                                  ),
                                  wrapWithModel(
                                    model: _model.secondQuestionModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Builder(builder: (_) {
                                      return DebugFlutterFlowModelContext(
                                        rootModel: _model.rootModel,
                                        child: const SecondQuestionWidget(
                                          description: ' labels \nbetter',
                                          image:
                                              'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMwAAADACAMAAAB/Pny7AAAAZlBMVEX///8AAABeXl7d3d38/Pz5+fmhoaHs7Ozw8PCRkZH29vbn5+d4eHilpaXKyspmZmY5OTnAwMAcHBxYWFiYmJisrKzR0dEvLy9LS0tsbGxRUVFycnIRERFGRkaCgoI0NDQmJia2trZk4GK+AAAIFElEQVR4nN2d7YKqIBCGxY80Tcsy3dpq6/5v8my12yl5UYFZRnv/hz4yDMMwkOf9qaIPcZUf/O1jnCjeiLeByZbibWCynXgbmOxTvA1M/OiX6cMkvngbmHQj3gYm3Iv3gXllmTRMdBRvAxP74m1gsl2bZbowT3Pl5GEQy1RhYsQyUZh0iVimCRNJfmy6MKGCZZIwGwXLBGGivYplejAJHvs3HfOiqOsgi5M0CrlfdICwT27psFpW2yII4oj7dTsVLwaw/Or8mddBMtou0mK5W94pL4NR8iTaLFet/XkZc7+6pEiOkweq2VX1yLqnw4/167i7jMkdWLF867zZciM8pIphNHRoLtwUN4XKGEZTo8CZH4hoNmPw1BUVzaHKuFk8b0YEI8S+TLhhvIqMRpz442u6vvnuHG6YkJDmXKXMNFFORyMW3KZG2TdiXzDTUHoB0bAPnA6afREUZbk9Hc9DcdjjAfXs+T+hkQTbxeo8YJrdcofS836Ym4LZ8rjuo8m5nZrK0uRUUzbbtXek2qq4QzUFDcqbpUXVs3jI3b//qzCNIgkY5N043Gs2PN8oM5rBpWs5tOb2aRGi6UjPZnmjpmGfbyJgaV255jDoyFMda3cvjiV76O7EeVioO2fJvl6TaPp2AVL1yJlzTzcSTf+Whjp64HYCnnfShfHKlQKmYR82rb4ZstmUqfaqfPZh80ozaOcMVHbcNf/zl+3VXBfGy1Q+mtrQKu1fPM83A/c04xOG+dB+eKe2Yqb9myeaoRu0iWIvkTRISxqxNqCZ68J4MfYCDWVu8Nr9B32acK4L4yV40bbQfrZSwT3cMFhfnHRhvATCnOkizt9VR66/9jvpwnglpPG1n6xQ8Zict4Y0WhUa0KWtiLomfHL/hjRaMLicaEGTESieoyaDcTPXrZ0JUJi2IslyRq9hlj7Nt0/TgwkvqGvmFIm0uuX69WnS+UYvFQ7rcFYUQc221ehBnya5aOb14dJzZj9q5GrYtT5NpGkiEcqNEqygC7lVg1hAV/UHoLF2ASn6Rg4WGOix1ltqyE26yP+grlnZ7qgBKxMnktftEYoDLKMAZGVfTjbpamASCzs7i4GPXLrZagBzzdmu1K6WW1w7yv9ewMrGbrCCLPiXoz2gFBiF1ZwQglWsk+F/FXABG6sPKbcnnKXkAvBwm/aQY6Z6136BQWPjSIFjdmZl0M5sYg8wDTusBAF20Vg0B6zMYa1BSmrkoDXiTGm3gGGYxwBgynQ4ZOCQNY8124tMYR3r6Qmk0MyfD9yJ07o2YBnm7gzs/jitbo3l5y+NG5ODmZXTvd9ULk8zdkDhl/xh3MLIRyZWxm3JH4YkEzdYIEnTmL5AIsMQ5K40BKqKzqamEcuRnkHi3EIAZm3qgQCM23KJUJ7o1qYr54wbxrvQwQQyjOP6LzkEWJvO2m8Fwz5mkJmZrtrZvRnlmAF78o7nGUJvBiIA/knTdJ6J5DQcezhjHAF4cu6aPdA0z6fKa3DzD2OiVP6ae+PGwKFlp0feQR3NzrgxkFBwWv0JErTmCRXShALN883L6MCXcVr8CRIq5pbxVklAlJ516M4i8HiL5sDmFW/i3MYw3mpLA3ybNdm79gpYmZVdgPacJWgz8HCb9tAFGZwbtHuroB1snTeO/BnIp9ptncOiBkdL55K8qCEGJ6s/id62WyGIchu7MDcFp0BIiiV7VQArsz1/huq/2Uq0bCdsVDz34aJ4Dhzjti6eS9FhZaayRvtTjqjixEHXzMBRR/uwMEMXfukmaXRLgb+VS575074ECR4j1z1AHVz00115u28ozmqhYkmx0/P4wcbA3ltX2ewpbBtWf2smnQNfzPXDqlcamvxjgbrmS+8QiW/kAp9paI6cvBwG+i9f50tfYQzm2ufEOdFhIMUZap13u8FY0RB1jKe6wlDDo91hTGh+LY3sAJ1X4luJhrvbHxiTqO5O0xCub/EJ6uF78r8wJj7tFgtQxrYJvuRiP3S2ecCYONjZmvY4MCqju+pz4EP+w4jKgIb6Nh100uja/cP65gnGhEb//H63QDLgpsWg6O8ZZmwXLzxrN4TmBWYENJnqjqj9AJpXmBHQ1KprewacoW7BuC0ohrooYMShd4C2Yfj7Bp5yvGvTs1qRYPhp4Ar6rqbonNplGH4alP/51aLrtmUAYzLf0KrsulgtV7s1BCNm3DToiN5DG+XhcgjjuKoISBGk/cjPFTcZ4kmKOkzRVs/1v35VAM+mgGGnCfsuzD3uZtLgUcGw06S9VzOvj8tZ635W5X2Z3B466h43Nx3Oq8U2eKx21DD90cNf69JPc9f5eNqWZREU6n9AYre0zvlGW+w0XZ9aW+zzTde1pNrKuWOBtBp8xXe/2PvGKwlN7e8vf+lToLiP0ETsXsBLCDuHv2+8jPD/WrhZrrctU/0z0IE7srnpQkRjd0EGmS4NgbHR7cDYaruxnXXMDy3TK7r0/mnBZFi+FdbVzjj+3HEHNLLicu73/kcG0oL/f6eAwqDMT9r2thjffzf+KEyCOv/U8QfjZbkpioOg2FbL1RCX/TlulrvCKE3iLKjrosg7LG85yvHSIXVCQ+zH58d6pIbZcL+avpQwWuVEI5EKxp+cjXlKGLdHWKmEYSbhk2VBGIJqWBYhmKmyIJhBlR2jlAzjT3O8XCXBHKfok3/UhjE/CD8CtWDszsFx6xWmrzhl5HqB8acW87f0DKN5JmJ8eoKZ7Fz50H+Y6c6VDz1g+P/qz16/MJupj5erfmA+/nje/weL7VpHJB8s6wAAAABJRU5ErkJggg==',
                                          expectation: 'Understand',
                                        ),
                                      );
                                    }),
                                  ),
                                  wrapWithModel(
                                    model: _model.secondQuestionModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Builder(builder: (_) {
                                      return DebugFlutterFlowModelContext(
                                        rootModel: _model.rootModel,
                                        child: const SecondQuestionWidget(
                                          description:
                                              ' a healthy \nshopping list.',
                                          image:
                                              'data:image/png;base64,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',
                                          expectation: 'Create',
                                        ),
                                      );
                                    }),
                                  ),
                                  wrapWithModel(
                                    model: _model.secondQuestionModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Builder(builder: (_) {
                                      return DebugFlutterFlowModelContext(
                                        rootModel: _model.rootModel,
                                        child: const SecondQuestionWidget(
                                          description:
                                              ' time while \nshopping.',
                                          image:
                                              'data:image/png;base64,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',
                                          expectation: 'Save',
                                        ),
                                      );
                                    }),
                                  ),
                                  wrapWithModel(
                                    model: _model.secondQuestionModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Builder(builder: (_) {
                                      return DebugFlutterFlowModelContext(
                                        rootModel: _model.rootModel,
                                        child: const SecondQuestionWidget(
                                          description:
                                              ' about \nbalanced nutrition.',
                                          image:
                                              'data:image/png;base64,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',
                                          expectation: 'Learn',
                                        ),
                                      );
                                    }),
                                  ),
                                  wrapWithModel(
                                    model: _model.secondQuestionModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Builder(builder: (_) {
                                      return DebugFlutterFlowModelContext(
                                        rootModel: _model.rootModel,
                                        child: const SecondQuestionWidget(
                                          description:
                                              ' my food\nchoices over time.',
                                          image:
                                              'data:image/png;base64,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',
                                          expectation: 'Track',
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                child: Stack(
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
                                    child: Container(
                                      width: 305.0,
                                      height: 43.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF40E0D0),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: ((FFAppState().firstName ==
                                                        '') ||
                                                (FFAppState().lastName ==
                                                        '') ||
                                                (FFAppState().level == '') ||
                                                (FFAppState()
                                                        .expectations.isEmpty))
                                            ? null
                                            : () async {
                                                _model.userDataAddResponse =
                                                    await UserDataTable()
                                                        .insert({
                                                  'first_name':
                                                      FFAppState().firstName,
                                                  'last_name':
                                                      FFAppState().lastName,
                                                  'type': FFAppState().level,
                                                  'expectations':
                                                      '${FFAppState().expectations.elementAtOrNull(0)} , ${FFAppState().expectations.elementAtOrNull(1)} , ${FFAppState().expectations.elementAtOrNull(2)} , ${FFAppState().expectations.elementAtOrNull(3)} , ${FFAppState().expectations.elementAtOrNull(4)} , ${FFAppState().expectations.elementAtOrNull(5)}',
                                                  'user_id': currentUserUid,
                                                });
                                                if (_model
                                                        .userDataAddResponse !=
                                                    null) {
                                                  context.goNamed(
                                                      PurioProScreenWidget
                                                          .routeName);
                                                }

                                                safeSetState(() {});
                                              },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'vdrxnj9r' /* Done */,
                                        ),
                                        options: FFButtonOptions(
                                          width: 305.0,
                                          height: 43.0,
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: const Color(0xFF40E0D0),
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          disabledColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(TermsOfUseWidget.routeName);
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'o4toanfy' /* Terms & Conditions */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w100,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w100,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
