import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'WS Chat App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Main Chat Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int count = 0;
  final List<Message> messages = <Message>[];
  final TextEditingController messageController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              itemBuilder: (_, int index) => messages[index],
              itemCount: messages.length,
              reverse: true,
            ),
          ),
          new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                controller: userNameController,
                style: new TextStyle(color: Colors.blue),
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    hintText: "User Name"),
              ))
            ],
          ),
          new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                controller: messageController,
                style: new TextStyle(color: Colors.blue),
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    hintText: "Message"),
              ))
            ],
          ),
          new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                  child: new MaterialButton(
                onPressed: () {
                  sendMessage();
                },
                child: const Text("Send"),
                textTheme: ButtonTextTheme.accent,
                textColor: Colors.white,
                color: Colors.blue,
              ))
            ],
          )
        ],
      ),
    );
  }

  void sendMessage() {
    if (userNameController.text.length != 0 &&
        messageController.text.length != 0) {
      Message message = new Message(
        username: userNameController.text,
        content: messageController.text,
        animationController: new AnimationController(
            vsync: this, duration: new Duration(milliseconds: 500)),
      );
      setState(() {
        messages.insert(0, message);
        messageController.clear();
      });
      message.animationController.forward();
    }
  }

  @override
  void dispose() {
    for (Message message in messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class Message extends StatelessWidget {
  Message(
      {this.username,
      this.content,
      this.isMine = true,
      this.animationController});

  final String username;
  final String content;
  final bool isMine;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: animationController, curve: Curves.ease),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(8.0),
              child: new CircleAvatar(
                child: new Text(username[0]),
              ),
            ),
            new Container(
              padding: new EdgeInsets.only(left: 8.0, right: 8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    username,
                    style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: new Text(
                      content,
                      style: new TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
