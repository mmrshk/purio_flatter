import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'language_selection_model.dart';
export 'language_selection_model.dart';

class LanguageSelectionWidget extends StatefulWidget {
  const LanguageSelectionWidget({super.key});

  static String routeName = 'LanguageSelection';
  static String routePath = '/languageSelection';

  @override
  State<LanguageSelectionWidget> createState() => _LanguageSelectionWidgetState();
}

class _LanguageSelectionWidgetState extends State<LanguageSelectionWidget>
    with RouteAware {
  late LanguageSelectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LanguageSelectionModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _model.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LanguageSelectionWidget oldWidget) {
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

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ro':
        return 'Română';
      default:
        return languageCode.toUpperCase();
    }
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'ro':
        return '🇷🇴';
      default:
        return '🌍';
    }
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
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText('language_selection_title').isNotEmpty 
                  ? FFLocalizations.of(context).getText('language_selection_title')
                  : 'Language Selection',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
                  ),
            ),
            centerTitle: false,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FFLocalizations.of(context).getText('language_selection_subtitle').isNotEmpty
                      ? FFLocalizations.of(context).getText('language_selection_subtitle')
                      : 'Select your preferred language',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 16.0,
                      ),
                ),
                const SizedBox(height: 24.0),
                // Language options
                ...FFLocalizations.languages().map((languageCode) {
                  final isSelected = FFLocalizations.of(context).languageCode == languageCode;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          setAppLanguage(context, languageCode);
                          context.pop();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? FlutterFlowTheme.of(context).primary.withOpacity(0.1)
                                : FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: isSelected 
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                              width: isSelected ? 2.0 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                _getLanguageFlag(languageCode),
                                style: const TextStyle(fontSize: 24.0),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Text(
                                  _getLanguageName(languageCode),
                                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16.0,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                
                const Spacer(),
                
                // Information text
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText('language_selection_info').isNotEmpty
                              ? FFLocalizations.of(context).getText('language_selection_info')
                              : 'Changes will take effect immediately and be remembered for future app launches.',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 12.0,
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
      ),
    );
  }
}
