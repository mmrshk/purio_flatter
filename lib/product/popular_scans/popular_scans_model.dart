import '/flutter_flow/flutter_flow_util.dart';
import 'popular_scans_widget.dart' show PopularScansWidget;
import 'package:flutter/material.dart';

class PopularScansModel extends FlutterFlowModel<PopularScansWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
