import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management/data/issue.dart';

class IssuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IssuePageState();
  }
}

class _IssuePageState extends State<IssuePage> {
  @override
  Widget build(BuildContext context) {
    Issue issue = ModalRoute.of(context).settings.arguments;
    return CustomScrollView();
  }
}
