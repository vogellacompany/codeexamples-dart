class Profile {
  String username;
  String email;
  String avatarUrl;
}

class User {
  String username;
  String email;
  String password;
  // etc.

  // optional
  User(this.username, this.email, this.password);

  User.fromProfile(Profile profile)
      : this.username = profile.username,
        this.email = profile.email;
}

void main() {
  var profile = Profile()..username = "some-username"..email = "email@test.de";

  var user = new User.fromProfile(profile);

  print(user);
}