import 'package:built_value/built_value.dart';
import 'package:state_management/data/user.dart';

part 'issue.g.dart';

abstract class Issue implements Built<Issue, IssueBuilder> {
  @nullable
  int get number;
  @nullable
  String get state;
  @nullable
  String get title;
  @nullable
  String get body;
  @nullable
  User get user;

  Issue._();

  factory Issue([void Function(IssueBuilder) updates]) = _$Issue;
}
