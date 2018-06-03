import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  var textInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Please Enter Your Name',
            style: new TextStyle(color: Theme.of(context).primaryColor),
          ),
          new TextField(
            decoration: new InputDecoration(
                hintText: 'Your Name',
                hintStyle:
                    new TextStyle(color: Theme.of(context).primaryColor)),
            controller: textInputController,
          ),
          new RaisedButton(
            onPressed: () {
              return showDialog(
                  context: context,
                  child: new AlertDialog(
                    content: new Text(textInputController.text),
                  ));
            },
            color: Theme.of(context).primaryColor,
            child: new Text('Login'),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
