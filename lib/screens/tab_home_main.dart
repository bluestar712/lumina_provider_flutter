import 'package:flutter/material.dart';
import 'package:lumina/tabs/home_devices.dart';
import 'package:lumina/tabs/home_likes.dart';
import 'package:lumina/tabs/home_groups.dart';

class HomeMain extends StatefulWidget{
  @override
  HomeMainState createState() => HomeMainState();
}

class HomeMainState extends State<HomeMain> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            tabs: <Widget>[
              Tab(icon: Icon(Icons.star),),
              Tab(icon: Icon(Icons.group_add),),
              Tab(icon: Icon(Icons.devices),)
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              home_likes(),
              home_groups(),
              home_devices()
            ],
          ),
        ),
      ),
    );
  }
}