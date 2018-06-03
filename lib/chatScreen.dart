import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final String title = "WebSocket Demo";
  final WebSocketChannel channel = new IOWebSocketChannel.connect('ws://nodejs-ws-server.herokuapp.com/');

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<ChatScreen> {
  TextEditingController _controller = new TextEditingController();
  var currentText = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new TextFormField(
                controller: _controller,
                decoration: new InputDecoration(labelText: 'Send a message'),
              ),
            ),
            new StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                Map decodedData = JSON.decode(snapshot.data);
                if (decodedData['type'] == 'message') {
                  currentText = decodedData['data'];
                }
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: new Text(
                      (snapshot.hasData) && decodedData['type'] == 'message'
                          ? '${decodedData['data']}'
                          : currentText),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: new Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      var data = new Map();
      data['type'] = 'message';
      data['data'] = _controller.text;
      widget.channel.sink.add(JSON.encode(data));
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}