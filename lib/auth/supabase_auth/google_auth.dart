import '/backend/supabase/supabase.dart';
import '/app_state.dart';
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
    
    // Store the Google user's name in app state for later use
    FFAppState().firstName = firstName;
    FFAppState().lastName = lastName;
    
    // Check if user data already exists with complete profile (has type and expectations)
    final existingUserData = await UserDataTable().queryRows(
      queryFn: (q) => q.eq('user_id', supabaseUser.id),
    );
    
    if (existingUserData.isEmpty) {
      // Only create user data if this is a completely new user
      // Don't create user data for returning users who deleted their account
      // This will allow the 2 questions flow to trigger
      print('No existing user data found - user will go through onboarding flow');
    } else {
      // Check if the existing user data has complete profile
      final userData = existingUserData.first;
      if (userData.type?.isNotEmpty == true && userData.expectations?.isNotEmpty == true) {
        print('User data already exists with complete profile, skipping save');
      } else {
        print('User data exists but incomplete - user will go through onboarding flow');
      }
    }
  } catch (e) {
    print('Error checking Google user data: $e');
  }
}
