import 'package:picturn/Models/profile.dart';

class User {
  final String login;
  String password;
  final Profile profile;

  User(this.login, this.password, this.profile);
}
