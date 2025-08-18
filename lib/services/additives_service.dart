import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditivesService {
  /// Get additives for a specific product with full additive details
  static Future<List<AdditivesRow>> getProductAdditives(String productId) async {
    try {
      // First get the product_additives relationships
      final productAdditives = await ProductAdditivesTable().queryRows(
        queryFn: (q) => q.eq('product_id', productId),
      );
      
      if (productAdditives.isEmpty) {
        return [];
      }
      
      // Get the additive IDs
      final additiveIds = productAdditives.map((pa) => pa.additiveId).toList();
      
      // Fetch the full additive details by ID
      List<AdditivesRow> additives = [];
      for (String additiveId in additiveIds) {
        try {
          final additive = await AdditivesTable().queryRows(
            queryFn: (q) => q.eq('id', additiveId),
          );
          if (additive.isNotEmpty) {
            additives.add(additive.first);
          }
        } catch (e) {
          print('Error fetching additive $additiveId: $e');
        }
      }
      
      return additives;
    } catch (e) {
      print('Error fetching product additives: $e');
      return [];
    }
  }

  /// Get the appropriate description based on current language
  static String getLocalizedDescription(AdditivesRow additive, BuildContext context) {
    final currentLanguage = FFLocalizations.of(context).languageCode;
    
    if (currentLanguage == 'ro' && additive.roDescription != null && additive.roDescription!.isNotEmpty) {
      return additive.roDescription!;
    }
    
    return additive.description ?? additive.code;
  }

  /// Get risk level color based on risk level string
  static Color getRiskLevelColor(String riskLevel) {
    switch (riskLevel.toLowerCase().trim()) {
      case 'low risk':
      case 'free risk':
        return const Color(0xFF2ECC71); // Green for low/free risk
      case 'moderate risk':
        return const Color(0xFFFFA500); // Orange for moderate risk
      case 'high risk':
        return const Color(0xFFE74C3C); // Red for high risk
      default:
        print('Unknown risk level: "$riskLevel" - using grey');
        return const Color(0xFF6A7F98);
    }
  }

  /// Show additive information dialog
  static void showAdditiveInfoDialog(AdditivesRow additive, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              Text(
                additive.code,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
              ),
              const SizedBox(width: 8.0),
              if (additive.riskLevel != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getRiskLevelColor(additive.riskLevel!),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    additive.riskLevel!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                  ),
                ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description:',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                getLocalizedDescription(additive, context),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.normal),
                      color: const Color(0xFF6A7F98),
                      fontSize: 14.0,
                    ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      color: const Color(0xFF40A5A5),
                      fontSize: 16.0,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
