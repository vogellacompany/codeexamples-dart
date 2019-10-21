import 'package:state_management/data/user.dart';

class UserRepository {
  static UserBuilder fromJson(dynamic entry) {
    return UserBuilder()
      ..login = entry[_Constants.LOGIN]
      ..avatarUrl = entry[_Constants.AVATAR_URL]
      ..bio = entry[_Constants.BIO];
  }
}

class _Constants {
  static const LOGIN = 'login';
  static const AVATAR_URL = 'avatar_url';
  static const BIO = 'bio';
  static const CREATED_AT = 'created_at';
}
