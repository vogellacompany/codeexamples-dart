import 'package:flutter/material.dart';

import 'package:myapp/widget/widget-utils.dart';
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
  List<CryptoEntry> _list = [];

  @override
  initState() {
    super.initState();
    listenForEntries();
  }

  ///
  /// Loops through all entries contained in [watched] and invokes the utils method [APIUtils.getData] with the current [Currency].
  /// After successful answer from the API the data is automatically converted into a [CryptoEntry] and put into [_list].
  ///
  listenForEntries() {
    watched.forEach((c) async{
      var stream = await APIUtils.getData(c, <Currency>[Currencies.EURO]);
      stream.listen((entry) {
        print(entry);
        setState(() {
          _list.add(entry);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: WidgetUtils.buildAppBar(_refresh),
        body: buildBody()
      ),
    );
  }

  ///
  /// Clears [_list] and then reinvokes [listenForEntries] for a refresh of the data displayed on the screen.
  ///
  _refresh(){
    this._list.clear();
    listenForEntries();
  }

  ///
  /// Method for building the [Widget]s displayed on screen.
  ///
  Widget buildBody(){
    return new Center(
      child: new ListView(
        children: _list.map((entry) => new CryptoWidget(entry)).toList(),
      )
    );
  }
}

///
/// Data class that holds basic data about a single [Currency]
///
class CryptoEntry {

  final String titleAbr;
  final String titleFull;
  final Color color;
  final Map conversionRates;

  CryptoEntry(this.titleAbr, this.titleFull, this.color, this.conversionRates);

  CryptoEntry.fromJSON(Currency current, Map jsonMap) : 
    titleAbr = current.abr,
    titleFull = current.name,
    color = Colors.brown,
    conversionRates = jsonMap;

  String toString() => "Currency: $titleAbr";
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
            trailing: new Text("${_cryptoEntry.conversionRates[Currencies.EURO.abr]}${Currencies.EURO.symbol}", textScaleFactor: 2.0,),
          ),
        ]
      ),
    );
  }

}