import "dart:async";
import "dart:convert";
import 'package:http/http.dart' as http;

import 'package:myapp/crypto-rate/overview.dart';

final String apiUrl = "https://min-api.cryptocompare.com/data/price?";

class APIUtils {

    static getData(Currency from, List<Currency> to) async {
      var url = _buildURL(from.abr, to);
      var client = new http.Client();
      var streamedRes = await client.send(
        new http.Request('get', Uri.parse(url))
      );

      return streamedRes.stream
              .transform(UTF8.decoder)
              .transform(JSON.decoder)
              //.expand((jsonBody) => (jsonBody as Map)[0])
              .map((jsonCrypto) => new CryptoEntry.fromJSON(from, jsonCrypto))
              ;
    }

    static _buildURL(String from, List<Currency> to){
      String _tmp = apiUrl + "fsym=" + from + "&";
      String x = "tsyms=";
      for(int i = 0; i < to.length; i++){
        x = x + to[i].abr + ",";
      }
      print(_tmp + x);
      return _tmp + x;
    }

}

class Currency {
  
  final String name;
  final String symbol;
  final String abr;

  const Currency(this.name, this.symbol, this.abr);

}

class Currencies {

  static const Currency BITCOIN = const Currency("Bitcoin", "BTC", "BTC");
  static const Currency BITCOIN_CASH = const Currency("Bitcoin Cash", "BCH", "BCH");
  static const Currency LITECOIN = const Currency("Litecoin", "LTC", "LTC");
  static const Currency RIPPLE = const Currency("Ripple", "XRP", "XRP");
  static const Currency ETHERUM = const Currency("Etherum", "ETH", "ETH");
  static const Currency EURO = const Currency("Euro", "€", "EUR");
  static const Currency DOLLAR = const Currency("dollar", "\$", "USD");
  

}
