import 'package:flutter/material.dart';

class WidgetUtils {

  static AppBar buildAppBar(Function refresh){
    return new AppBar(
      title: new Text("CryptosRate"),
      elevation: 4.0,
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.refresh),
          onPressed: refresh,
        ),
      ]
    );
  }

}