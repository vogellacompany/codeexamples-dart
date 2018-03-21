import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(new CryptoRateApp());
}

class CryptoRateApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "CryptoRate",
      home: new Overview()
    );
  }
}

class Overview extends StatefulWidget{
  @override
  State createState() => new OverviewState();
}

/// 
///
class OverviewState extends State<Overview> {

  Map<String, CryptoEntry> _map = <String, CryptoEntry>{};

  @override
  initState() {
    super.initState();
    listenForEntries();
  }

  /// calls the api and then extracts the given data. After that this function sets the state of app
  /// whicht refreshes and rebuilds the list that is shown to the user, 
  /// 
  listenForEntries() async{
    _map.putIfAbsent("BTC", () => new CryptoEntry("Bitcoin", "BTC", 0.0));
    _map.putIfAbsent("BTC", () => new CryptoEntry("Bitcoin Cash", "BCH", 0.0));
    _map.putIfAbsent("BTC", () => new CryptoEntry("Litecoin", "LTC", 0.0));
    _map.putIfAbsent("BTC", () => new CryptoEntry("Ripple", "XRP", 0.0));
  	_map.putIfAbsent("BTC", () => new CryptoEntry("Etherum", "ETH", 0.0));
    var url = "https://min-api.cryptocompare.com/data/pricemulti?tsyms=EUR&fsyms=BTC,BCH,LTC,XRP,ETH";
    var httpClient = new HttpClient();
    Map data;
    try{
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if(response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        data = JSON.decode(json);
        data.forEach((e, x) {
          double conversionRate = x["EUR"];
          CryptoEntry entry = _map[e];
          setState(() =>
            entry.conversionRate = conversionRate
          );
        });
      }
    }catch(exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("CryptoRate"),
          elevation: 4.0,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: _refresh,
            ),
          ]
        ),
        body: new RefreshIndicator(
          child: new Center(
            child: new ListView(
              children: _map.values.map((entry) => new CryptoWidget(entry)).toList(),
            )
          ),
          onRefresh: _refresh(),
        )
      ),
    );
  }

  /// Clears [_list] and then reinvokes [listenForEntries] for a refresh of the data displayed on the screen.
  _refresh(){
    this._map.clear();
    listenForEntries();
  }

}

/// Data class that holds basic data about a single Currency
class CryptoEntry extends Comparable<CryptoEntry>{

  final String name;
  final String abreviation;
  double conversionRate;

  CryptoEntry(this.name, this.abreviation, this.conversionRate);

  String toString() => "Currency: $abreviation";

  @override
  int compareTo(CryptoEntry other) {
    return other.conversionRate < this.conversionRate ? -1 : 1;
  }
}

/// Reusable widget that displays basic information contained in a [CryptoEntry] instance
class CryptoWidget extends StatelessWidget{

  final CryptoEntry _cryptoEntry;

  CryptoWidget(this._cryptoEntry);

  @override
  Widget build(BuildContext context){
    return new Card(
      elevation: 1.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: new CircleAvatar(
              child: new Text(_cryptoEntry.titleAbr),
            ),
            title: new Text(_cryptoEntry.titleAbr),
            subtitle: new Text(_cryptoEntry.titleFull),
            trailing: new Text("${_cryptoEntry.conversionRate}€", textScaleFactor: 2.0,),
          ),
        ]
      ),
    );
  }
}
