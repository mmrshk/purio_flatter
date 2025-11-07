import 'dart:io';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/feedback_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  static const int _maxPhotoAttachments = 5;
  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _attachedPhotos = [];

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

  void _showMaxPhotosSnackbar() {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          FFLocalizations.of(context).getText('feedback_photo_limit'),
        ),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }

  void _showPhotoErrorSnackBar([Object? error]) {
    print('❌ Error selecting feedback photo: $error');
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          FFLocalizations.of(context).getText('feedback_photo_error'),
        ),
        backgroundColor: FlutterFlowTheme.of(context).error,
      ),
    );
  }

  Future<void> _openPhotoSourceSheet() async {
    if (_attachedPhotos.length >= _maxPhotoAttachments) {
      _showMaxPhotosSnackbar();
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: Text(
                    FFLocalizations.of(context)
                        .getText('feedback_photo_camera'),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _pickFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: Text(
                    FFLocalizations.of(context)
                        .getText('feedback_photo_gallery'),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _pickFromGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFromCamera() async {
    if (_attachedPhotos.length >= _maxPhotoAttachments) {
      _showMaxPhotosSnackbar();
      return;
    }

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
      );

      if (image != null && mounted) {
        setState(() {
          _attachedPhotos.add(File(image.path));
        });
      }
    } catch (e) {
      _showPhotoErrorSnackBar(e);
    }
  }

  Future<void> _pickFromGallery() async {
    if (_attachedPhotos.length >= _maxPhotoAttachments) {
      _showMaxPhotosSnackbar();
      return;
    }

    try {
      final remainingSlots = _maxPhotoAttachments - _attachedPhotos.length;
      final images = await _imagePicker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
      );

      if (!mounted || images.isEmpty) {
        return;
      }

      final selectedFiles = images
          .take(remainingSlots)
          .map((image) => File(image.path))
          .toList();

      if (selectedFiles.isNotEmpty) {
        setState(() {
          _attachedPhotos.addAll(selectedFiles);
        });
      }

      if (images.length > remainingSlots) {
        _showMaxPhotosSnackbar();
      }
    } catch (e) {
      _showPhotoErrorSnackBar(e);
    }
  }

  void _removePhoto(int index) {
    if (!mounted || index < 0 || index >= _attachedPhotos.length) {
      return;
    }

    setState(() {
      _attachedPhotos.removeAt(index);
    });
  }

  Future<void> _submitFeedback() async {
    final feedbackText = _model.textController.text.trim();

    if (feedbackText.isEmpty && _attachedPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(FFLocalizations.of(context)
              .getText('feedback_enter_message_or_photo')),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final success = await FeedbackService.saveFeedback(
      feedbackText: feedbackText,
      photos: List<File>.from(_attachedPhotos),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      if (success) {
        _attachedPhotos.clear();
      }
    });

    if (success) {
      _model.textController?.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            FFLocalizations.of(context).getText('feedback_success'),
          ),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
      context.safePop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            FFLocalizations.of(context).getText('feedback_error'),
          ),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    }
  }

  Widget _buildPhotoAttachmentSection(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final localizations = FFLocalizations.of(context);
    final canAddMorePhotos = _attachedPhotos.length < _maxPhotoAttachments;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.alternate,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.image_outlined,
                color: theme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                localizations.getText('feedback_add_photo'),
                style: theme.bodyMedium.override(
                  font: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontStyle: theme.bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${_attachedPhotos.length}/$_maxPhotoAttachments',
                style: theme.bodySmall.override(
                  font: GoogleFonts.roboto(
                    fontStyle: theme.bodySmall.fontStyle,
                    fontWeight: theme.bodySmall.fontWeight,
                  ),
                  letterSpacing: 0.0,
                  color: theme.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            localizations.getText('feedback_photo_hint'),
            style: theme.bodySmall.override(
              font: GoogleFonts.roboto(
                fontStyle: theme.bodySmall.fontStyle,
                fontWeight: theme.bodySmall.fontWeight,
              ),
              letterSpacing: 0.0,
              color: theme.secondaryText,
            ),
          ),
          if (_attachedPhotos.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(_attachedPhotos.length, (index) {
                final file = _attachedPhotos[index];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        file,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: InkWell(
                        onTap: () => _removePhoto(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: canAddMorePhotos ? _openPhotoSourceSheet : null,
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(
              localizations.getText('feedback_add_photo_action'),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.primary,
              side: BorderSide(color: theme.primary),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              textStyle: theme.bodyMedium.override(
                font: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontStyle: theme.bodyMedium.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (!canAddMorePhotos)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                localizations.getText('feedback_photo_limit'),
                style: theme.bodySmall.override(
                  font: GoogleFonts.roboto(
                    fontStyle: theme.bodySmall.fontStyle,
                    fontWeight: theme.bodySmall.fontWeight,
                  ),
                  letterSpacing: 0.0,
                  color: theme.secondaryText,
                ),
              ),
            ),
        ],
      ),
    );
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
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
                                      minLines: 6,
                                      maxLines: null,
                                      textAlignVertical: TextAlignVertical.top,
                                      textCapitalization: TextCapitalization.sentences,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        labelText: FFLocalizations.of(context).getText(
                                          'pkpdfk4m',
                                        ),
                                        alignLabelWithHint: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 12,
                                        ),
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                              ),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        hintText: FFLocalizations.of(context).getText(
                                          'pkpdfk4m',
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
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).alternate,
                                            width: 1.5,
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
                                        fillColor:
                                            FlutterFlowTheme.of(context).secondaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                          ),
                                      cursorColor:
                                          FlutterFlowTheme.of(context).primaryText,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildPhotoAttachmentSection(context),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (_isLoading) {
                                return;
                              }
                              await _submitFeedback();
                            },
                            text: _isLoading
                                ? FFLocalizations.of(context)
                                    .getText('feedback_sending')
                                : FFLocalizations.of(context)
                                    .getText('fxp8nvjw' /* Send */),
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
