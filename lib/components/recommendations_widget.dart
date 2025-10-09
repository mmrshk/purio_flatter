import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/services/health_score_service.dart';
import '/product/product_details/product_details_widget.dart';
import '/product/recommendations/recommendations_list_widget.dart';
import '/components/product_image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationsWidget extends StatelessWidget {
  const RecommendationsWidget({
    super.key,
    required this.recommendedProduct,
    required this.isLoading,
    required this.currentProduct,
  });

  final ProductRow? recommendedProduct;
  final bool isLoading;
  final ProductRow currentProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Recommendations Header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FFLocalizations.of(context).getText('xme295my' /* Recommendations */),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: Colors.black,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendationsListWidget(
                        currentProduct: currentProduct,
                      ),
                    ),
                  );
                },
                child: Text(
                  FFLocalizations.of(context).getText('4h3ql1fs' /* See All */),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: const Color(0xFF40A5A5),
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ],
          ),
        ),
        
        // Description
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 18.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
                             Text(
                 FFLocalizations.of(context).getText('whclgaz0' /* Looking for a healthier altern... */),
                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                       font: GoogleFonts.roboto(
                         fontWeight: FontWeight.normal,
                         fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                       ),
                       color: Colors.black,
                       fontSize: 12.0,
                       letterSpacing: 0.0,
                       fontWeight: FontWeight.normal,
                       fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                     ),
               ),
            ],
          ),
        ),
        
        // Recommendation Content
        if (isLoading)
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 23.0),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Color(0xFF40A5A5),
              ),
            ),
          )
        else if (recommendedProduct != null)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 23.0),
            child: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsWidget(
                        product: recommendedProduct!,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0F7FA), Color(0xFFE8F5E9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: recommendedProduct!.imageFrontUrl != null && recommendedProduct!.imageFrontUrl!.isNotEmpty
                              ? Image.network(
                                  recommendedProduct!.imageFrontUrl!,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return ProductImagePlaceholder(
                                      width: 80.0,
                                      height: 80.0,
                                      borderRadius: 8.0,
                                    );
                                  },
                                )
                              : ProductImagePlaceholder(
                                  width: 80.0,
                                  height: 80.0,
                                  borderRadius: 8.0,
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                recommendedProduct!.category ?? 'Category',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                                      color: const Color(0xFF6A7F98),
                                      fontSize: 14.0,
                                    ),
                              ),
                              Text(
                                recommendedProduct!.name ?? 'Product Name',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              if (recommendedProduct!.healthScore != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: HealthScoreService.getHealthScoreColor(recommendedProduct!.displayScore ?? recommendedProduct!.healthScore ?? 0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    'Safety: ${recommendedProduct!.displayScore ?? recommendedProduct!.healthScore}/100',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF40A5A5),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 23.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'No recommendations available',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: const Color(0xFF6A7F98),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
