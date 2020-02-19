class Profile {

  String username;
  String email;
  String avatarUrl;

  Profile(this.username, this.email, {this.avatarUrl});
}

// Usage:

void main() {
  new Profile("Some-username", "email@test.com", avatarUrl: 'some-url');
}
