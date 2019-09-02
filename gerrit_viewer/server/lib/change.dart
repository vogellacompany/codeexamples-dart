import 'package:json_annotation/json_annotation.dart';

part 'change.g.dart'; // <1>

@JsonSerializable()
class Change {
  String id;
  String project;
  String branch;
  @JsonKey(name: 'change_id') // <2>
  String changeId;
  String subject;
  @JsonKey(name: '_number')
  int number;

  Change(this.id, this.project, this.branch, this.changeId, this.subject,
      this.number);

  factory Change.fromJson(Map<String, dynamic> json) =>
      _$ChangeFromJson(json); // <3>

  Map<String, dynamic> toJson() => _$ChangeToJson(this); // <3>
}
