import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User _user;
  String get getUserName => this._user.displayName;
  String get getUserAvatarImagePath => this._user.photoURL;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        this._user = user;
        print('User is signed in!');
      }
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}