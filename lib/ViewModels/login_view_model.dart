import 'package:picturn/Repositories/auth_repository.dart';

class LoginViewModel{
  AuthRepository authRepository = AuthRepository();

  Future<void> signInWithGoogle() async{
    return await this.authRepository.signInWithGoogle();
  }

  void signOutGoogle() async{
    this.authRepository.signOutGoogle();
  }

}