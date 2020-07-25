import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Swipe extends StatefulWidget {
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('Hello'),
        onPressed: () async{
          String temp;
          FirebaseUser _user = await _auth.currentUser();

          await _firestore.collection("users").getDocuments().then((querySnapshot) {
            querySnapshot.documents.forEach((result) {
              if (result['uid'] == _user.uid.toString()) {
                temp = result['mongoID'];
              }
            });
          });

          Map data = {
            "id": temp
          };
          var response = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/findhackerbyid',
              headers: {"Content-Type": "application/json"},
              body: json.encode(data)
          );
          print(response.body);
        },
      ),
    );
  }
}
