import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/pages/home.dart';
import 'package:hackybirthday/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:hackybirthday/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:hackybirthday/classes/user_classes.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;
  String username;
  UserId mongoID;
  String age;
  String gender;
  String major;
  String tagline;
  String school;
  String school_year;
  Map<String, bool> skillset = {'backend': false, 'frontend': false, 'fullstack': false, 'hardware': false, 'mobile': false,
  'javascript': false, 'python': false, 'react': false, 'angular': false, 'java': false, 'c': false, 'c++': false, 'gcp': false, 'aws': false, 'mongodb': false, 'firebase': false};
  final Firestore _firestore = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> registerUser(response) async{
    AuthResult user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser _user = await _auth.currentUser();
    mongoID = userIdFromJson(response);
    await _firestore.collection('users').document(username).setData({
    'email' : email,
    'uid' : _user.uid,
    'username': username,
      'tagline': tagline,
    'age': age,
    'gender': gender,
    'major': major,
    'school': school,
    'year': school_year,
    'skills': skillset,
      'mongoID': mongoID.id
    });


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
          title: Text('Register'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()
                  )
              );
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(

              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  TextField(
                      onChanged: (value) => username = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'Enter Your Username',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'Enter Your Email',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      autocorrect: false,
                      obscureText: true,
                      onChanged: (value) => password = value,
                      decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key),
                          hintText: 'Enter Your Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(3))
                          )
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      onChanged: (value) => age = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.more_vert),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'Age',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      onChanged: (value) => tagline = value,
                      maxLines: null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.more_vert),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'A Short Tagline',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      onChanged: (value) => gender = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.more_vert),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'Gender',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      onChanged: (value) => major = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.more_vert),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'Major',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => school = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.more_vert),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'School',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      onChanged: (value) => school_year = value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.more_vert),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        hintText: 'School Year',
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Divider(thickness: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Skills:', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['backend'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['backend'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Backend')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['frontend'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['frontend'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Frontend')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['fullstack'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['fullstack'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Fullstack')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['hardware'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['hardware'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Hardware')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['mobile'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['mobile'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Mobile')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['javascript'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['javascript'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('JavaScript')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['python'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['python'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Python')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['react'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['react'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('React.js')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['angular'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['angular'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Angular.js')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['java'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['java'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Java')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['c'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['c'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('C')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['c++'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['c++'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('C++')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['gcp'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['gcp'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Google Cloud Platform')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['aws'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['aws'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Amazon Web Services')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['mongodb'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['mongodb'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('MongoDB')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: skillset['firebase'],
                            onChanged: (bool value) {
                              setState(() {
                                skillset['firebase'] = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Firebase')
                        ],
                      ),
                    ],
                  ),

                  CustomButton(
                    text: 'Register',
                    callback: () async {
                      Map data = {
                      'username': username.toString().toLowerCase(),
                      'age': age.toString().toLowerCase(),
                      'gender': gender.toString().toLowerCase(),
                      'tagline': tagline.toString().toLowerCase(),
                      'major': major.toString().toLowerCase(),
                      'school': school.toString().toLowerCase(),
                      'year': school_year.toString().toLowerCase(),
                      };
                      data.addAll(skillset);
                      var response = await http.post('https://us-central1-aiot-fit-xlab.cloudfunctions.net/addahacker',
//                      var response = await http.post('http://eba25431e6c2.ngrok.io/dummyJson',
                          headers: {"Content-Type": "application/json"},
                          body: json.encode(data)
                      );
                      await registerUser(response.body);
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
