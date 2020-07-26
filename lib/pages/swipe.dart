import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackybirthday/classes/profile.dart';
import 'dart:convert';
import 'package:hackybirthday/widgets/profile_card.dart';

class Swipe extends StatefulWidget {
  final List<String> swipes;
  final String mongoID;

  const Swipe({Key key, this.swipes,this.mongoID}) : super(key: key);
  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  List<Profile> profileList = [];


  Future getProfileDetails() async {
    widget.swipes.forEach((element) async{
      Map data = {
                  "id": element
                };
                var response = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/findhackerbyid',
                    headers: {"Content-Type": "application/json"},
                    body: json.encode(data)
               );
                profileList.add(profileFromJson(response.body));
    });
    print(profileList);
    return profileList;
  }

  Widget match() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Text(
              "Match!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget dismiss() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              "Pass",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
//            FlatButton(
//              child: Text('Hello'),
//              onPressed: () async{
//                print(widget.swipes);
//                String temp;
//                FirebaseUser _user = await _auth.currentUser();
//
//                await _firestore.collection("users").getDocuments().then((querySnapshot) {
//                  querySnapshot.documents.forEach((result) {
//                    if (result['uid'] == _user.uid.toString()) {
//                      temp = result['mongoID'];
//                    }
//                  });
//                });
//
//                Map data = {
//                  "id": temp
//                };
//                var response = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/findhackerbyid',
//                    headers: {"Content-Type": "application/json"},
//                    body: json.encode(data)
//                );
//                print(response.body);
//              },
//            ),
          FutureBuilder(
            builder: (context, profileSnap) {
              if (profileSnap.connectionState == ConnectionState.none &&
                  profileSnap.hasData == null) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: profileList.length,
                itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) async{
                        setState(() {
                          profileList.removeAt(index);
                        });
                        if (direction == DismissDirection.endToStart){
                          Map data = {
                            "id": widget.mongoID,
                            "otherid": widget.swipes[index]
                          };
                          var response = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/matchhacker',
                              headers: {"Content-Type": "application/json"},
                              body: json.encode(data)
                          );
                        } else {
                          print('Pass');
                        }
                      },
                      secondaryBackground: match(),
                      background: dismiss(),
                      child: ProfileCard(profile: profileList[index]),
                      key: UniqueKey(),
                    );
                },
              );
            },
            future: getProfileDetails(),
          );
  }
}
