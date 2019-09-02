import 'dart:convert';
import 'dart:io';

import '../lib/fetcher.dart';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4, // <1>
    4040, // <2>
  );
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    request.response.headers.add("Access-Control-Allow-Origin", "*"); // <3>
    request.response.headers
        .add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");

    var changes = await new Fetcher().fetchChanges();
    request.response.write(jsonEncode(changes)); // <4>
    await request.response.close();
  }
}
