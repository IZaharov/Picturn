import 'package:firebase_auth/firebase_auth.dart';
import 'package:picturn/Models/profile.dart';
import 'package:picturn/Repositories/auth_provider.dart';

class AuthRepository{
  AuthProvider authProvider = AuthProvider();

  Future<UserCredential> signInWithGoogle() async{
    return await this.authProvider.signInWithGoogle();
  }

  void signOutGoogle() async{
    this.authProvider.signOutGoogle();
  }

  Profile getProfile() {
    return Profile(this.authProvider.getUserName, this.authProvider.getEMail ,avatarImagePath: this.authProvider.getUserAvatarImagePath);
  }
}