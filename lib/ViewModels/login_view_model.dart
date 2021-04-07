import 'package:picturn/Repositories/auth_repository.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:picturn/runtime_data.dart';

class LoginViewModel {
  AuthRepository authRepository = AuthRepository();

  Future<void> signInWithGoogle() async {
    return await this.authRepository.signInWithGoogle().then((_) =>
        RuntimeData.currentUserProfileViewModel =
            ProfileViewModel(this.authRepository.getProfile()));
  }

  void signOutGoogle() async {
    this.authRepository.signOutGoogle();
  }
}
