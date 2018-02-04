import 'package:flutter/material.dart';

import 'package:myapp/main.dart';

class ChatMessage extends StatelessWidget {

	ChatMessage({this.text, this.animationController});

	final String text;
	final AnimationController animationController;

	@override
	Widget build(BuildContext context){
		return new SizeTransition(
			sizeFactor: new CurvedAnimation(
				parent: animationController, curve: Curves.decelerate
			),
			axisAlignment: 0.0,
			child: new Container(
				margin: const EdgeInsets.symmetric(vertical: 10.0),
				child: new Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						new Container(
							margin: const EdgeInsets.only(right: 16.0),
							child: new CircleAvatar(child: new Text(name[0])),
						),
						new Expanded(
							child: new Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: <Widget>[
									new Text(
										name,
										style: Theme.of(context).textTheme.subhead
									),
									new Container(
										margin: const EdgeInsets.only(top: 5.0),
										child: new Text(text)
									)
								],
							)
						)
					],
				)
			)
		);
	}


}