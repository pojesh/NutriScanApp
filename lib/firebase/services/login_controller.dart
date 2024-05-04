import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  Future<void> login() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        googleAccount.value = account;
        // Retrieve email address
        print('Email Address: ${account.email}');
      } else {
        // Handle sign-in failure
        print('Failed to sign in with Google');
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
      // Handle sign-in errors
    }
  }
}
