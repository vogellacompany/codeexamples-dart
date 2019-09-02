import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:server/change.dart'; // <1>

const CHANGES_URL = "http://localhost:4040"; // <2>

void main() async {
  var root = querySelector('#root'); // <3>
  root.children.addAll((await getChanges()).map(newChange));
}

Element newChange(Change change) {
  var element = DivElement()
    ..classes = ["change"]
    ..id = '${change.number}'; // <4>

  element.children.add(AnchorElement()
    ..href = 'https://git.eclipse.org/r/#/c/${change.number}/'
    ..text = change.subject
    ..classes = ["subject"]);

  element.children.add(SpanElement()
    ..text = '${change.project} ${change.branch}'
    ..addEventListener('click', (event) => showDialog(change.branch)));

  return element;
}

void showDialog(String message) {
  context.callMethod('alert', [message]); // <5>
}

Future<Iterable<Change>> getChanges() async {
  var changes = await HttpRequest.getString(CHANGES_URL);
  return (jsonDecode(changes) as List).map((json) => Change.fromJson(json));
}
