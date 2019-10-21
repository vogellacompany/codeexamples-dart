import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/pages/not_found.dart';
import 'package:state_management/repository/issue_repository.dart';
import 'package:state_management/util/routes.dart' as routes;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IssueRepository>.value(
          value: IssueRepository(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: routes.routes,
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => NotFoundPage());
        },
        initialRoute: '/',
      ),
    );
  }
}
