import 'package:flutter/material.dart';

import 'package:myapp/widget/widget-utils.dart';
import 'package:myapp/api/api-utils.dart';

class Overview extends StatefulWidget{
  @override
  State createState() => new OverviewState();
}

const List<Currency> watched = const <Currency>[Currencies.BITCOIN, Currencies.BITCOIN_CASH, Currencies.ETHERUM, Currencies.RIPPLE, Currencies.LITECOIN];

class OverviewState extends State<Overview> {

  List<CryptoEntry> _list = [];

  @override
  initState() {
    super.initState();
    listenForEntries();
  }

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

  int _screen = 0;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: WidgetUtils.buildAppBar(_refresh),
        body: buildBody(),
        bottomNavigationBar: WidgetUtils.buildBottomNavigationBar(_handleNavigationBarTap, _screen)
      ),
    );

  }

  void _handleNavigationBarTap(int index){
    print("index: " + index.toString());
    setState(() {
      _screen = index;
    });
  }
  void _refresh(){
    _list.clear();
    listenForEntries();
  }

  Widget buildBody(){
    switch(_screen){
      case 1:
        return new TabBarView(
          children: new List<Widget>.generate(6, (index) {
            return new Center(
              child: new Text("Ja moin $index")
            );
          })
        );
        break;
      default:
        return new Center(
          child: new ListView(
            children: _list.map((entry) => new CryptoWidget(entry)).toList(),
          )
        );
        break;
    }
  }
}

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