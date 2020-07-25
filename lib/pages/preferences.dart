import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/pages/registration.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('jhe'),
        onPressed: (){
          Navigator.pop(context);
          Navigator.push(context,
          MaterialPageRoute(
            builder: (BuildContext context) => Registration()
          )
          );
        },
      ),
    );
  }
}
