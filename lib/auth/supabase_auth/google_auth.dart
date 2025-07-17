import '/backend/supabase/supabase.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> googleSignInFunc() async {
  print('Starting Google Sign-In process with proper configuration...');
  
  try {
    // Configure Google Sign-In with explicit client IDs and scopes
    const webClientId = '536569478939-0olcvii80nvei9c187lfnndrtp0t3qpu.apps.googleusercontent.com';
    const iosClientId = '536569478939-o2kigbe7kl6qd4kq75b0tc9v49n7kif9.apps.googleusercontent.com';
      

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    
    print('Attempting Google Sign-In...');
    final googleUser = await googleSignIn.signIn();
    
    if (googleUser == null) {
      print('Google Sign-In was cancelled by user');
      return null;
    }
    
    print('Google Sign-In successful, getting authentication...');
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    
    print('Got Google tokens, signing in with Supabase...');

    final response = await SupaFlow.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    
    print('Supabase authentication successful');
    
    // Extract user info from Google profile and save to database
    final currentUser = SupaFlow.client.auth.currentUser;
    if (currentUser != null && googleUser != null) {
      await _saveGoogleUserData(currentUser, googleUser);
    }
    
    // Return the current user after successful authentication
    return currentUser;
    
  } catch (e) {
    print('Error during Google Sign-In: $e');
    return null;
  }
}

/// Saves Google user data to the database
Future<void> _saveGoogleUserData(User supabaseUser, GoogleSignInAccount googleUser) async {
  try {
    print('Saving Google user data to database...');
    
    // Extract name from Google profile
    final firstName = googleUser.displayName?.split(' ').first ?? '';
    final lastName = googleUser.displayName?.split(' ').skip(1).join(' ') ?? '';
    
    print('Google user name: $firstName $lastName');
    
    // Check if user data already exists
    final existingUserData = await UserDataTable().queryRows(
      queryFn: (q) => q.eq('user_id', supabaseUser.id),
    );
    
    if (existingUserData.isEmpty) {
      // Insert new user data
      await UserDataTable().insert({
        'user_id': supabaseUser.id,
        'first_name': firstName,
        'last_name': lastName,
        'type': '', // Will be filled in later
        'expectations': '', // Will be filled in later
      });
      print('Google user data saved successfully');
    } else {
      print('User data already exists, skipping save');
    }
  } catch (e) {
    print('Error saving Google user data: $e');
  }
}
