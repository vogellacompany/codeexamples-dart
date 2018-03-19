import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:myapp/api/api-utils.dart';

///
/// 
///
class Overview extends StatefulWidget{
  @override
  State createState() => new OverviewState();
}

const List<Currency> watched = const <Currency>[Currencies.BITCOIN, Currencies.BITCOIN_CASH, Currencies.ETHERUM, Currencies.RIPPLE, Currencies.LITECOIN];
///
/// 
///
class OverviewState extends State<Overview> {

///
/// relevant: https://stackoverflow.com/questions/12888206/how-can-i-sort-a-list-of-strings-in-dart
///
  Map<String, CryptoEntry> _map = <String, CryptoEntry>{};

  @override
  initState() {
    super.initState();
    watched.forEach((Currency currency) {
      _map.putIfAbsent(currency.abr, () => new CryptoEntry(currency.abr, currency.name, null, 0.0, currency));
    });
    listenForEntries();
  }

  ///
  /// Loops through all entries contained in [watched] and invokes the utils method [APIUtils.getData] with the current [Currency].
  /// After successful answer from the API the data is automatically converted into a [CryptoEntry] and put into [_list].
  ///
  listenForEntries() async{
    var url = "https://min-api.cryptocompare.com/data/pricemulti?tsyms=EUR&fsyms=";
    var httpClient = new HttpClient();
    watched.forEach((Currency c) {
      url += c.abr;
      url += ",";
    });
    print(url);
    Map data;
    try{
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if(response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        data = JSON.decode(json);
        data.forEach((e, x) {
          double convRate = x["EUR"];
          CryptoEntry entry = _map[e];
          setState(() =>
            entry.conversionRate = convRate
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
        appBar: buildAppBar(),
        body: buildBody()
      ),
    );
  }

  ///
  /// Clears [_list] and then reinvokes [listenForEntries] for a refresh of the data displayed on the screen.
  ///
  _refresh(){
    this._map.clear();
    listenForEntries();
  }

  ///
  /// Method for building the [Widget]s displayed on screen.
  ///
  Widget buildBody(){
    return new RefreshIndicator(
      child: new Center(
        child: new ListView(
          children: _map.values.map((entry) => new CryptoWidget(entry)).toList(),
        )
      ),
      onRefresh: _refresh(),
    );
  }

  ///
  /// Method for building the [AppBar] on top of the screen.
  ///
  AppBar buildAppBar(){
    return new AppBar(
      title: new Text("CryptosRate"),
      elevation: 4.0,
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.refresh),
          onPressed: _refresh,
        ),
      ]
    );
  }
}

///
/// Data class that holds basic data about a single [Currency]
///
class CryptoEntry extends Comparable<CryptoEntry>{

  final String titleAbr;
  final String titleFull;
  final Color color;
  double conversionRate;
  final Currency currency;

  CryptoEntry(this.titleAbr, this.titleFull, this.color, this.conversionRate, this.currency);

  String toString() => "Currency: $titleAbr";

  @override
  int compareTo(CryptoEntry other) {
    if(other.conversionRate < this.conversionRate){
      return -1;
    }else{
      return 1;
    }
  }
}

///
/// Reusable widget that displays basic information contained in a [CryptoEntry] instance
///
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
            trailing: new Text("${_cryptoEntry.conversionRate}${Currencies.EURO.symbol}", textScaleFactor: 2.0,),
          ),
        ]
      ),
    );
  }
}