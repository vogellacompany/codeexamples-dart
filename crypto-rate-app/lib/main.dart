import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:myapp/crypto-rate/overview.dart';

import 'package:myapp/theme/android.dart';

void main() {
	runApp(new CryptoRateApp());
}

class CryptoRateApp extends StatelessWidget {

	@override
	Widget build(BuildContext context){
		return new MaterialApp(
			title: "CryptoRate",
			theme: androidTheme,
			home: new Overview()
		);
	}

}

