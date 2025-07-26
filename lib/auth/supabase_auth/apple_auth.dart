import '/backend/supabase/supabase.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Performs Apple sign in on iOS or macOS
Future<User?> appleSignInFunc() async {
  try {
    final rawNonce = SupaFlow.client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );
    
    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
          'Could not find ID Token from generated credential.');
    }
    
    final response = await SupaFlow.client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
    
    // Extract user info from Apple profile and save to database
    final currentUser = response.user;
    if (currentUser != null) {
      await _saveAppleUserData(currentUser, credential);
    }
    
    // Return the current user after successful authentication
    return currentUser;
    
  } catch (e) {
    return null;
  }
}

/// Saves Apple user data to the database
Future<void> _saveAppleUserData(User user, dynamic credential) async {
  try {
    // Check if user already exists in our database
    final existingUser = await SupaFlow.client
        .from('users')
        .select()
        .eq('user_id', user.id)
        .single();
    
    if (existingUser == null) {
      // Create new user record
      await SupaFlow.client.from('users').insert({
        'user_id': user.id,
        'email': user.email,
        'full_name': '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      // Apple user already exists in database
    }
  } catch (e) {
    // Error saving Apple user data
  }
} 