import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/additives_service.dart';
import 'package:flutter/material.dart';
import 'additives_screen_model.dart';

export 'additives_screen_model.dart';

class AdditivesScreen extends StatefulWidget {
  const AdditivesScreen({Key? key}) : super(key: key);

  @override
  _AdditivesScreenState createState() => _AdditivesScreenState();
}

class _AdditivesScreenState extends State<AdditivesScreen> {
  late AdditivesScreenModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdditivesScreenModel());
    _model.setOnUpdate(
      onUpdate: () {
        if (mounted) {
          setState(() {});
        }
      },
      updateOnChange: true,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            FFLocalizations.of(context).getText('ba1vcuow' /* Additives */),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: TextFormField(
                  controller: _model.searchController ??= TextEditingController(),
                  focusNode: _model.searchFocusNode,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Search additives...',
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
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
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    prefixIcon: Icon(
                      Icons.search,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  onChanged: (value) {
                    _model.updateSearchQuery(value);
                  },
                ),
              ),
              Expanded(
                child: _model.isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Loading additives...',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : _model.getFilteredAdditives().isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _model.searchQuery.isEmpty 
                                      ? 'No additives available'
                                      : 'No additives found',
                                  style: FlutterFlowTheme.of(context).bodyLarge,
                                ),
                                if (_model.searchQuery.isEmpty) ...[
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      _model.loadAdditives();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await _model.loadAdditives();
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              controller: _model.listViewController,
                              scrollDirection: Axis.vertical,
                              itemCount: _model.getFilteredAdditives().length + (_model.hasMoreData ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == _model.getFilteredAdditives().length) {
                                  return _model.isLoadingMore
                                      ? Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context).primary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }
                                
                                final additive = _model.getFilteredAdditives()[index];
                                return _buildAdditiveCard(additive);
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditiveCard(AdditivesRow additive) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
      child: InkWell(
        onTap: () {
          AdditivesService.showAdditiveInfoDialog(additive, context);
        },
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            additive.code,
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 8),
                          if (additive.riskLevel != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AdditivesService.getRiskLevelColor(additive.riskLevel!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                additive.riskLevel!,
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        FFLocalizations.of(context).languageCode == 'ro' 
                            ? additive.roName 
                            : additive.name,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      if (AdditivesService.getLocalizedDescription(additive, context).isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          AdditivesService.getLocalizedDescription(additive, context),
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
