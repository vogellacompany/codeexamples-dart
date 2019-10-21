import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/data/issue.dart';
import 'package:state_management/repository/issue_repository.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  IssueRepository repository;

  @override
  Widget build(BuildContext context) {
    repository = Provider.of<IssueRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub viewer'),
      ),
      body: FutureBuilder(
        future: repository.getIssues('eclipse', 'dartboard'),
        builder: (context, AsyncSnapshot<List<Issue>> snapshot) {
          if (snapshot.hasData) {
            return _IssueView(snapshot.data);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _IssueView extends StatelessWidget {
  final List<Issue> issues;

  _IssueView(this.issues);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: issues.map((issue) => _IssueCard(issue)).toList(),
    );
  }
}

class _IssueCard extends StatelessWidget {
  final Issue _issue;

  _IssueCard(this._issue);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/issue', arguments: _issue),
        child: ListTile(
          leading: Icon(Icons.access_alarms),
          title: Text(_issue.title),
          subtitle: Text(_issue.user.login),
        ),
      ),
    );
  }
}
