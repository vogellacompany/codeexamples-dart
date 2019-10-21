// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Issue extends Issue {
  @override
  final int number;
  @override
  final String state;
  @override
  final String title;
  @override
  final String body;
  @override
  final User user;

  factory _$Issue([void Function(IssueBuilder) updates]) =>
      (new IssueBuilder()..update(updates)).build();

  _$Issue._({this.number, this.state, this.title, this.body, this.user})
      : super._();

  @override
  Issue rebuild(void Function(IssueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IssueBuilder toBuilder() => new IssueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Issue &&
        number == other.number &&
        state == other.state &&
        title == other.title &&
        body == other.body &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, number.hashCode), state.hashCode), title.hashCode),
            body.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Issue')
          ..add('number', number)
          ..add('state', state)
          ..add('title', title)
          ..add('body', body)
          ..add('user', user))
        .toString();
  }
}

class IssueBuilder implements Builder<Issue, IssueBuilder> {
  _$Issue _$v;

  int _number;
  int get number => _$this._number;
  set number(int number) => _$this._number = number;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  IssueBuilder();

  IssueBuilder get _$this {
    if (_$v != null) {
      _number = _$v.number;
      _state = _$v.state;
      _title = _$v.title;
      _body = _$v.body;
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Issue other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Issue;
  }

  @override
  void update(void Function(IssueBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Issue build() {
    _$Issue _$result;
    try {
      _$result = _$v ??
          new _$Issue._(
              number: number,
              state: state,
              title: title,
              body: body,
              user: _user?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Issue', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
