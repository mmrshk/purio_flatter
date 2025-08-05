import '/backend/supabase/supabase.dart';
import '/app_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> googleSignInFunc() async {
  try {
    const webClientId = '536569478939-0olcvii80nvei9c187lfnndrtp0t3qpu.apps.googleusercontent.com';
    const iosClientId = '536569478939-o2kigbe7kl6qd4kq75b0tc9v49n7kif9.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final response = await SupaFlow.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  
    
    // Extract user info from Google profile and save to database
    final currentUser = SupaFlow.client.auth.currentUser;
    if (currentUser != null && googleUser != null) {
      await _saveGoogleUserData(currentUser, googleUser);
    }
    
    // Return the current user after successful authentication
    return currentUser;
    
      } catch (e) {
      return null;
    }
}

/// Saves Google user data to the database
Future<void> _saveGoogleUserData(User supabaseUser, GoogleSignInAccount googleUser) async {
  try {
    final firstName = googleUser.displayName?.split(' ').first ?? '';
    final lastName = googleUser.displayName?.split(' ').skip(1).join(' ') ?? '';

    FFAppState().firstName = firstName;
    FFAppState().lastName = lastName;
    
    // Check if user already exists in our database
    final existingUser = await SupaFlow.client
        .from('users')
        .select()
        .eq('user_id', supabaseUser.id)
        .single();
    
    if (existingUser == null) {
      // Create new user record
      await SupaFlow.client.from('users').insert({
        'user_id': supabaseUser.id,
        'email': supabaseUser.email,
        'first_name': firstName,
        'last_name': lastName,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      // Update existing user's name if it has changed
      await SupaFlow.client.from('users').update({
        'first_name': firstName,
        'last_name': lastName,
      }).eq('user_id', supabaseUser.id);
    }
  } catch (e) {
    // Error saving Google user data
  }
}
