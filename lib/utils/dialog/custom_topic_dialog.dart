import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusVisibilityDemo extends StatefulWidget {
  @override
  _FocusVisibilityDemoState createState() =>  _FocusVisibilityDemoState();
}


class _FocusVisibilityDemoState extends State<FocusVisibilityDemo> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(title:  Text('Text Dialog Demo')),
      body:  Center(
        child:  RaisedButton(
          onPressed: _showDialog,
          child:  Text("Push Me"),
        ),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child:  _SystemPadding(child:  AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content:  Row(
          children: <Widget>[
             Expanded(
              child:  TextField(
                autofocus: true,
                decoration:  InputDecoration(
                    labelText: 'Full Name', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
           FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
           FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),),
    );
  }
}


class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return  AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}