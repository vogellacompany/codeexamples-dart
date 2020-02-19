class User {
  String username;
  String email;
  String password;
  // etc.

  void printSelf() {
    print("$username $email $password}");
  }
}

void main() {
  var user = User()
    ..username = "some-username"
    ..email = "some-email"
    ..password = "some-password"
    ..printSelf();

  print("${user.username} ${user.email} ${user.password}");
}
