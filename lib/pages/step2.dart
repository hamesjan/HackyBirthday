import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/classes/people_swipe.dart';
import 'package:hackybirthday/pages/home.dart';
import 'package:hackybirthday/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:hackybirthday/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:hackybirthday/classes/user_classes.dart';

class StepTwo extends StatefulWidget {
  final String mongoID;

  const StepTwo({Key key, this.mongoID}) : super(key: key);

  @override
  _StepTwoState createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  String haveidea;
  String idea;
  String focusarea;
  String focuscommit;
  String teamsize;
  String gendermix;
  String teamskill;
  String newskill;
  String win;
  String learn;
  String buildComplete;
  String friend;

  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerUser(response) async{
    FirebaseUser _user = await _auth.currentUser();
    FirebaseUser temp = await getUser();

    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(
            builder: (BuildContext context) => Home()
        )
    );
  }

  Future<FirebaseUser> getUser() async{
    return _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Quick Survey'),
        ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Do you have an idea?'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: haveidea,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            haveidea = newValue;
                          });
                        },
                        items: <String>['Yes', 'No','Partial']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      onChanged: (value) => idea = value,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'If yes, give a brief overview of your idea.',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text('What area would you like to work in?'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: focusarea,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            focusarea = newValue;
                          });
                        },
                        items: <String>['Education', 'Healthcare', 'Gaming', 'Fintech', 'Accessibility', 'Entertainment', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('How commited are you to your focus area?'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: focuscommit,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            focuscommit = newValue;
                          });
                        },
                        items: <String>['1', '2', '3', '4', '5']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('What is your idea team size?'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: teamsize,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            teamsize = newValue;
                          });
                        },
                        items: <String>['2', '3', '4', '5+']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Would you prefer a single gender team?'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: gendermix,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            gendermix = newValue;
                          });
                        },
                        items: <String>['Yes', 'No', 'No Preference']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Would you like teamates with\na diverse technology background?'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: teamskill,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            teamskill = newValue;
                          });
                        },
                        items: <String>['Yes', 'No']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Text('How willing are you to learn a new skill?\n(1 - not willing; 5 - very willing)'),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: newskill,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            newskill = newValue;
                          });
                        },
                        items: <String>['1', '2', '3', '4', '5']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(thickness: 3,),
                  Text('Rate the importance of the following motivations from 1-5.'),
                  Divider(thickness: 1,),
                  SizedBox(
                    height: 10,
                  ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 100,),
                          Text('Winning & Prizes'),
                          SizedBox(width: 10,),
                          DropdownButton<String>(
                            value: win,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                win = newValue;
                              });
                            },
                            items: <String>['1', '2', '3', '4', '5']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                  SizedBox(
                    height: 10,
                  ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 100,),
                          Text('Learning'),
                          SizedBox(width: 60,),
                          DropdownButton<String>(
                            value: learn,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                learn = newValue;
                              });
                            },
                            items: <String>['1', '2', '3', '4', '5']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                  SizedBox(
                    height: 10,
                  ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 100,),
                          Text('Building a cool\nproject'),
                          SizedBox(width: 25,),
                          DropdownButton<String>(
                            value: buildComplete,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                buildComplete = newValue;
                              });
                            },
                            items: <String>['1', '2', '3', '4', '5']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                  SizedBox(
                    height: 10,
                  ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 100,),
                          Text('Meeting Friends'),
                          SizedBox(width: 15,),
                          DropdownButton<String>(
                            value: friend,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                friend = newValue;
                              });
                            },
                            items: <String>['1', '2', '3', '4', '5']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'Submit',
                    callback: () async {
                      Map data = {
                        "id" : widget.mongoID,
                        "haveidea" : haveidea.toString().toLowerCase(),
                        "idea" : idea.toString().toLowerCase(),
                        "focusarea" : focusarea.toString().toLowerCase(),
                        "focuscommit" : focuscommit.toString().toLowerCase(),
                        "teamsize" : teamsize.toString().toLowerCase(),
                        "gendermix" : gendermix.toString().toLowerCase(),
                        "teamskill" : teamskill.toString().toLowerCase(),
                        "newskill" : newskill.toString().toLowerCase(),
                        "win" : win.toString().toLowerCase(),
                        "learn" : learn.toString().toLowerCase(),
                        "build" : buildComplete.toString().toLowerCase(),
                        "friend" : friend.toString().toLowerCase()
                      };
                      var response = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/addahackermatcher',
                          headers: {"Content-Type": "application/json"},
                          body: json.encode(data)
                      );
                      Map data2 = {
                        "id" : widget.mongoID,
                      };
                      var response2 = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/gethackers',
                          headers: {"Content-Type": "application/json"},
                          body: json.encode(data2)
                      );
                      print(response2.body);
                      print(response.body);
                      Navigator.pop(context);
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Home(swipes: peopleListFromJson(response2.body).ids,)
                      ));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
        )
    );
  }
}
