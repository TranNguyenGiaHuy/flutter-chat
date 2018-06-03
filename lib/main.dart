import 'package:flutter/material.dart';
import 'loginScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return new MaterialApp(
      title: title,
      home: new LoginScreen(),
      theme: new ThemeData(
        primaryColor: Colors.purple
      ),
    );
  }
}
