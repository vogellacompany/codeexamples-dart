import 'package:flutter/material.dart';

import 'package:myapp/chat/chat_message.dart';

class ChatScreen extends StatefulWidget {
	@override
	State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

	final List<ChatMessage> _messages = <ChatMessage>[];
	final TextEditingController _textController = new TextEditingController();

	bool _isComposing = false;

	@override	
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text("Friendlychat"),
				elevation: 4.0,
			),
			body: new Column(
				children: <Widget>[
					new Flexible(
						child: new ListView.builder(
							padding: new EdgeInsets.all(8.0),
							reverse: true,
							itemBuilder: (_, int index) => _messages[index],
							itemCount: _messages.length,
						),
					),
					new Divider(height: 1.0),
					new Container(
						decoration: new BoxDecoration(
							color: Theme.of(context).cardColor
						),
						child: _buildTextComposer(),
					)
				],
			)
		);
	}

	Widget _buildTextComposer() {
		return new IconTheme(
			data: new IconThemeData(color: Theme.of(context).accentColor),
			child: new Container (
				margin: const EdgeInsets.symmetric(horizontal: 8.0),
				child: new Row(
					children: <Widget>[
						new Flexible(
							child: new TextField(
								controller: _textController,
								onChanged: (String text) {
									setState(() {
										_isComposing = text.length > 0;
									});
								},
								onSubmitted: _handleSubmitted,
								decoration: new InputDecoration.collapsed(
									hintText: "Send a message"
								),
							),
						),
						new Container (
							margin: new EdgeInsets.symmetric(horizontal: 4.0),
							child: new IconButton(
								icon: new Icon(Icons.send),
								onPressed: _isComposing 
									? () => _handleSubmitted(_textController.text)
									: null,
							),
						)
					],
				)
			)
		);
	}

	void _handleSubmitted(String text){
		_textController.clear();
		setState(() {
			_isComposing = false;
		});
		ChatMessage message = new ChatMessage(
			text: text,
			animationController: new AnimationController(
				duration: new Duration(milliseconds: 300),
				vsync: this
			),
		);
		setState(() {
			_messages.insert(0, message);
		});
		message.animationController.forward();
	}

	@override
	void dispose() {
		for(ChatMessage message in _messages){
			message.animationController.dispose();
			super.dispose();
		}
	}
}