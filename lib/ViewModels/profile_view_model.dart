import 'package:picturn/Models/profile.dart';

class ProfileViewModel {
  Profile profile;

  ProfileViewModel(this.profile);

  String get getAvatarImagePath => this.profile.avatarImagePath;

  bool equalProfiles(Profile profile) {
    return this.profile.nickName == profile.nickName;
  }

  int fetchCountPosts() {
    //TODO метод репозитория, которому кидаем профиль
    return 5;
  }

  int fetchCountLikes() {
    //TODO метод репозитория, которому кидаем профиль
    return 123;
  }
}
