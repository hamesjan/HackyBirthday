import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/pages/home.dart';
import 'package:hackybirthday/pages/login.dart';
import 'package:hackybirthday/pages/step2.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

Widget getAuthState(){
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() async{
    return _auth.currentUser();
  }

  getUser().then((user) {
    if (user != null) {
      return Home();

    }
    return Login();
  });
  return Login();
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
      ),
      home: Login(),
//      home: StepTwo()
    );
  }
}

