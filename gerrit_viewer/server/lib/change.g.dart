// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Change _$ChangeFromJson(Map<String, dynamic> json) {
  return Change(
      json['id'] as String,
      json['project'] as String,
      json['branch'] as String,
      json['change_id'] as String,
      json['subject'] as String,
      json['_number'] as int);
}

Map<String, dynamic> _$ChangeToJson(Change instance) => <String, dynamic>{
      'id': instance.id,
      'project': instance.project,
      'branch': instance.branch,
      'change_id': instance.changeId,
      'subject': instance.subject,
      '_number': instance.number
    };
