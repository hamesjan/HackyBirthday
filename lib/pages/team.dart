import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Team extends StatefulWidget {
  final String mongoID;

  const Team({Key key, this.mongoID}) : super(key: key);

  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> {
  List names = ['google guy', 'James', 'mr-robot', 'Uworld'];
  List discord = ['derrik#1323', 'James Han#6764', 'RobotSir#9823', 'Uworld#1294'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make some matches and come back!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(width: MediaQuery.of(context).size.width,),
            Icon(Icons.favorite),
            Text('Thank you for using HackerMatch!', style: TextStyle(
              fontSize: 22
            ),)
          ],
        ),
    );
//      Scaffold(
//      appBar: AppBar(
//        title: Text('Your Team!'),
//      ),
//      body:ListView.builder(
//        itemCount: 4,
//        itemBuilder: (context, index) {
//          return Card(
//            child: ListTile(
//              title: Text(names[index]),
//              trailing: Text(discord[index]),
//            ),
//          );
//        },
//      )
//    );
  }
}
