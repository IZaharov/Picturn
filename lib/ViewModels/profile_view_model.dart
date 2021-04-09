import 'package:picturn/Models/profile.dart';

class ProfileViewModel {
  Profile profile;

  ProfileViewModel(this.profile);

  String get getAvatarImagePath => this.profile.avatarImagePath;

  bool equalProfiles(Profile profile) {
    return this.profile.nickName == profile.nickName;
  }
}
