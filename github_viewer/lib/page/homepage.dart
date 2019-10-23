import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_viewer/page/issue_page.dart';
import 'package:github_viewer/util/util.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class Issue {
  int number;
  String state;
  String title;
  String body;
  String userName;
  DateTime createdAt;
}

class _HomepageState extends State<Homepage> {
  Future<List<Issue>> issues;

  @override
  Widget build(BuildContext context) {
    issues = getIssues();
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Issue Viewer'),
      ),
      body: FutureBuilder(
        future: issues,
        builder: (BuildContext context, AsyncSnapshot<List<Issue>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                return issues = getIssues();
              },
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return _IssueCard(snapshot.data[index]);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<List<Issue>> getIssues() async {
    const url = 'https://api.github.com/repos/flutter/flutter/issues';
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      // GitHub's API is kind of restrictive
      // If the response's status code is not 200 (OK) we show the error indicating what went wrong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(data['message']),
          actions: <Widget>[
            SimpleDialogOption(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      return Future.error(data);
    }

    return data
        .map<Issue>((entry) => Issue()
          ..number = entry['number']
          ..state = entry['state']
          ..title = entry['title']
          ..body = entry['body']
          ..userName = entry['user']['login']
          ..createdAt = DateTime.parse(entry['created_at']))
        .toList();
  }
}

class _IssueCard extends StatelessWidget {
  final Issue issue;

  _IssueCard(this.issue);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text('${issue.title} #${issue.number}'),
          subtitle: Text(
              '${issue.userName} opened ${formatDate(issue.createdAt)} ago'),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => IssuePage(issue),
              ),
            );
          },
        ),
      ),
    );
  }
}
