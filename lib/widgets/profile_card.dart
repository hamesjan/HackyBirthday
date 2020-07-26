import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/classes/profile.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  ProfileCard({this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(profile.username),
          )
        ],
      ),
    );
  }
}