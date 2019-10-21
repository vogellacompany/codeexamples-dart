class GithubPaths {
  static const BASE_URL = 'https://api.github.com';
  static String users() => '/users';
  static String issues(String owner, String repo) =>
      '$BASE_URL/repos/$owner/$repo/issues';

  GithubPaths._();
}
