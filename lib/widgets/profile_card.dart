import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/classes/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  ProfileCard({this.profile});

  Widget getskills(bool str, String title){
    if (str) {
      return Text('$title', style: TextStyle(
          fontSize: 22
      ));
    } else return SizedBox(height: 0, width: 0,);
  }

  Widget displaySelectedFile() {
    return new ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child:new Image(image: AssetImage(
          'assets/images/profilepic.png',
      ),
      fit: BoxFit.fill,)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(profile.username, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),),
              Text(', ', style: TextStyle(
                  fontSize: 22
              )),
              Text(profile.age, style: TextStyle(
                  fontSize: 22
              ))
            ],
          ),
          SizedBox(height: 5,),
          displaySelectedFile(),
          SizedBox(height: 5,),
          Divider(
            thickness: 3,
          ),
          SizedBox(height: 5,),
          Text(profile.gender, style: TextStyle(
              fontSize: 22,
            color: profile.gender == 'male' ? Colors.blue : Colors.pink
          )),
          Text(
            'Major: ${profile.major}', style: TextStyle(
            fontSize: 22
          ),
          ),
          SizedBox(height: 5,),
          Text(
            'School: ${profile.school}', style: TextStyle(
              fontSize: 22
          ),
          ),
          SizedBox(height: 5,),
          Text(
            'School Year: ${profile.year}', style: TextStyle(
              fontSize: 22
          ),
          ),
          SizedBox(height: 5,),
          SizedBox(height: 5,),
          Text(
            profile.tagline, style: TextStyle(
              fontSize: 22
          ),
          ),
          SizedBox(height: 5,),
          Divider(
            thickness: 3,
          ),
          SizedBox(height: 5,),
              Column(
                children: <Widget>[
                  Text('Skills: ', style: TextStyle(
                      fontSize: 25,
                    fontWeight: FontWeight.bold
                  )),
                  getskills(profile.backend, 'Backend'),
                  getskills(profile.frontend, 'Frontend'),
                  getskills(profile.fullstack, 'FullStack'),
                  getskills(profile.hardware, 'Hardware'),
                  getskills(profile.mobile, 'Mobile'),
                  getskills(profile.react, 'React.js'),
                  getskills(profile.angular, 'Angular.js'),
                  getskills(profile.javascript, 'JavaScript'),
                  getskills(profile.python, 'Python'),
                  getskills(profile.java, 'Java'),
                  getskills(profile.c, 'C'),
                  getskills(profile.profileC, 'C++'),
                  getskills(profile.gcp, 'Google Cloud Platform'),
                  getskills(profile.aws, 'Amazon Web Services'),
                  getskills(profile.mongodb, 'MongoDB'),
                  getskills(profile.firebase, 'Firebase')
                ],
              )
        ],

      ),
    )
    );
  }
}