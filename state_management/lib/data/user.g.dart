// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String login;
  @override
  final String avatarUrl;
  @override
  final String bio;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._({this.login, this.avatarUrl, this.bio}) : super._() {
    if (login == null) {
      throw new BuiltValueNullFieldError('User', 'login');
    }
    if (avatarUrl == null) {
      throw new BuiltValueNullFieldError('User', 'avatarUrl');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        login == other.login &&
        avatarUrl == other.avatarUrl &&
        bio == other.bio;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, login.hashCode), avatarUrl.hashCode), bio.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('login', login)
          ..add('avatarUrl', avatarUrl)
          ..add('bio', bio))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _login;
  String get login => _$this._login;
  set login(String login) => _$this._login = login;

  String _avatarUrl;
  String get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String avatarUrl) => _$this._avatarUrl = avatarUrl;

  String _bio;
  String get bio => _$this._bio;
  set bio(String bio) => _$this._bio = bio;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _login = _$v.login;
      _avatarUrl = _$v.avatarUrl;
      _bio = _$v.bio;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result =
        _$v ?? new _$User._(login: login, avatarUrl: avatarUrl, bio: bio);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
