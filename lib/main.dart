import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'chatScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return new MaterialApp(
      title: title,
      home: new ChatScreen(),
    );
  }
}
