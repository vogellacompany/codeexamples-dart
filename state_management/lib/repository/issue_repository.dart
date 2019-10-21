import 'dart:convert';

import 'package:state_management/data/issue.dart';
import 'package:http/http.dart' as http;
import 'package:state_management/data/user.dart';
import 'package:state_management/repository/user_repository.dart';
import 'package:state_management/util/github_paths.dart';

class IssueRepository {
  Future<List<Issue>> getIssues(String owner, String repo) async {
    // var response = await http.get(GithubPaths.issues(owner, repo));

    // var data = jsonDecode(response.body);
    // print(data);

    // return data.map((entry) {
    //   return Issue((issue) => issue
    //     ..number = entry[_Constants.NUMBER]
    //     ..state = entry[_Constants.STATE]
    //     ..title = entry[_Constants.TITLE]
    //     ..body = entry[_Constants.BODY]
    //     ..user = UserRepository.fromJson(entry[_Constants.USER]));
    // }).toList();
    return [
      Issue((issue) => issue
        ..number = 1
        ..state = 'open'
        ..title = 'test issue'
        ..body = 'Somebody'
        ..user = (UserBuilder()
          ..login = 'jonas-jonas'
          ..avatarUrl = ''))
    ];
  }
}

class _Constants {
  static const NUMBER = 'number';
  static const STATE = 'state';
  static const TITLE = 'title';
  static const BODY = 'body';
  static const USER = 'user';
}
