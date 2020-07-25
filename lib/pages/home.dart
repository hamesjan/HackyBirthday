import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackybirthday/pages/swipe.dart';
import 'package:hackybirthday/pages/team.dart';
import 'package:hackybirthday/pages/preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome', style: TextStyle(
            color: Colors.black,
            fontSize: 22
        ),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black,),
            onPressed: (){
            },
          )
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Preferences(),
            Swipe(),
            Team(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.black12,
          unselectedLabelColor: Colors.black38,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.map, color: Colors.black,),
              child: Text(
                'Progress',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            Tab(
              icon: Icon(Icons.poll, color:  Colors.black,),
              child: Text(
                'Package Info', style: TextStyle(
                  color: Colors.black
              ),
              ),
            ),
            Tab(
              icon: Icon(Icons.phone, color: Colors.black,),
              child: Text(
                'Contact',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
