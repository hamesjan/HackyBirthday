import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackybirthday/pages/home.dart';
import 'package:hackybirthday/pages/registration.dart';
import 'package:hackybirthday/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackybirthday/classes/people_swipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  String temp1;

  Future<FirebaseUser> getUser() async{
    return _auth.currentUser();
  }

  signInUser() async{
    AuthResult user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser temp = await getUser();

    await _firestore.collection("users").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result['uid'] == temp.uid.toString()) {
          temp1 = result['mongoID'];
        }
      });
    });

    Map data2 = {
      "id" : temp1,
    };
    var response2 = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/gethackers',
        headers: {"Content-Type": "application/json"},
        body: json.encode(data2)
    );

    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(
            builder: (BuildContext context) => Home(swipes: peopleListFromJson(response2.body).ids)
        )
    );
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            TextField(
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    icon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                    hintText: 'Email',
                    fillColor: Colors.deepPurpleAccent
                )
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
                onChanged: (value) => password = value,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))
                    )
                )
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Login',
              callback: () {
                signInUser();
              } ,
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              text: 'Register',
              callback: (){
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Registration()
                    )
                );
              },
            )

          ],
        ),
      ),
    );
  }
}