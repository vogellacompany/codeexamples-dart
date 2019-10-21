import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_viewer/data/issue.dart';
import 'package:github_viewer/data/issue_comment.dart';
import 'package:github_viewer/util/util.dart';
import 'package:http/http.dart' as http;

class IssuePage extends StatefulWidget {
  final Issue issue;

  IssuePage(this.issue);

  @override
  State<StatefulWidget> createState() {
    return _IssueState();
  }
}

class _IssueState extends State<IssuePage> {
  Future<List<IssueComment>> comments;

  @override
  Widget build(BuildContext context) {
    comments = getComments();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.issue.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: comments,
        builder:
            (BuildContext context, AsyncSnapshot<List<IssueComment>> snapshot) {
          if (snapshot.hasData) {
            var widgets = <Widget>[_IssueContent(widget.issue)];
            if (snapshot.data.length > 0) {
              widgets.add(Divider());
              widgets.addAll(snapshot.data
                  .map<Widget>((comment) => _IssueComment(comment))
                  .toList());
            }

            return ListView(children: widgets);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<List<IssueComment>> getComments() async {
    var url =
        'https://api.github.com/repos/flutter/flutter/issues/${widget.issue.number}/comments';
    var response = await http.get(url);

    var data = jsonDecode(response.body);

    return data
        .map<IssueComment>((entry) => IssueComment()
          ..body = entry['body']
          ..userName = entry['user']['login']
          ..createdAt = DateTime.parse(entry['created_at']))
        .toList();
  }
}

class _IssueComment extends StatelessWidget {
  final IssueComment comment;

  _IssueComment(this.comment);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(right: 12.0, left: 12, bottom: 12),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: _ItemInfo(
                      comment.userName,
                      'commented ${formatDate(comment.createdAt)} ago',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    _showActionsDialog(context);
                  },
                )
              ],
            ),
            MarkdownBody(
              data: comment.body,
            )
          ],
        ),
      ),
    );
  }

  void _showActionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('asd'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Delete'),
            ),
            SimpleDialogOption(
              child: Text('Delete'),
            )
          ],
        );
      },
    );
  }
}

class _ItemInfo extends StatelessWidget {
  final String firstPart;
  final String secondPart;

  _ItemInfo(this.firstPart, this.secondPart);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstPart,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' $secondPart',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class _IssueContent extends StatelessWidget {
  final Issue issue;
  _IssueContent(this.issue);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            _IssueStateRow(issue),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MarkdownBody(data: issue.body),
            ),
          ],
        ),
      ),
    );
  }
}

const stateColors = {'open': Colors.green, 'closed': Colors.red};

class _IssueStateRow extends StatelessWidget {
  final Issue issue;

  _IssueStateRow(this.issue);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Container(
              padding: EdgeInsets.all(3),
              child: Text(
                '${issue.state}',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: stateColors[issue.state],
                borderRadius: BorderRadiusDirectional.all(
                  Radius.circular(3),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _ItemInfo(
            issue.userName,
            'opened this issue ${formatDate(issue.createdAt)} ago',
          ),
        )
      ],
    );
  }
}
