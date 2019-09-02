import 'dart:io';
import 'dart:convert';
import './change.dart';

const CHANGES_URL =
    'https://git.eclipse.org/r/changes/?q=status:open+project:platform/eclipse.platform.ui';

class Fetcher {
  Future<List<Change>> fetchChanges() async {
    HttpClientRequest request =
        await HttpClient().getUrl(Uri.parse(CHANGES_URL));
    var response = await request.close();
    var body = await response.transform(Utf8Decoder()).join();
    body = body.replaceAll(r")]}'",
        ""); // <1> 

    var changes = <Change>[];
    for (var x in jsonDecode(body)) {
      changes.add(Change.fromJson(x));
    }
    return changes;
  }
}
