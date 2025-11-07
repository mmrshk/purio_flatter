import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProductSubmissionService {
  /// Upload image to Supabase Storage and return the public URL
  static Future<String?> uploadProductImage(File imageFile, String barcode) async {
    try {
      final userId = currentUserUid;
      if (userId.isEmpty) {
        print('❌ User not authenticated');
        return null;
      }

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'pending_products/$userId/${barcode}_$timestamp.jpg';

      // Read image file as bytes
      final imageBytes = await imageFile.readAsBytes();

      // Upload to Supabase Storage
      await Supabase.instance.client.storage
          .from('product-images') // Make sure this bucket exists in Supabase
          .uploadBinary(
            fileName,
            imageBytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: false,
            ),
          );

      // Get public URL
      final publicUrl = Supabase.instance.client.storage
          .from('product-images')
          .getPublicUrl(fileName);

      print('✅ Image uploaded successfully: ${publicUrl}');
      return publicUrl;
    } catch (e) {
      print('❌ Error uploading image: $e');
      return null;
    }
  }

  /// Save product submission to database
  static Future<bool> submitProduct({
    required String barcode,
    required String imageUrl,
  }) async {
    try {
      final userId = currentUserUid;
      if (userId.isEmpty) {
        print('❌ User not authenticated');
        return false;
      }

      // Insert submission
      await PendingProductSubmissionTable().insert({
        'barcode': barcode,
        'image_front_url': imageUrl,
        'user_id': userId, // Using auth user ID
        'status': 'pending',
      });

      print('✅ Product submission saved successfully');
      return true;
    } catch (e) {
      print('❌ Error saving product submission: $e');
      return false;
    }
  }

  /// Complete flow: Take photo, upload, and save submission
  static Future<bool> submitProductWithPhoto({
    required String barcode,
    required File imageFile,
  }) async {
    // Upload image first
    final imageUrl = await uploadProductImage(imageFile, barcode);
    if (imageUrl == null) {
      return false;
    }

    // Save submission
    return await submitProduct(
      barcode: barcode,
      imageUrl: imageUrl,
    );
  }
}

