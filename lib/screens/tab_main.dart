import 'package:flutter/material.dart';
import 'package:lumina/screens/tab_home_main.dart';
import 'package:lumina/screens/tab_group.dart';
import 'package:lumina/screens/tab_profile.dart';
import 'package:lumina/screens/tab_schedule.dart';
import 'package:lumina/screens/tab_setting.dart';
import 'package:lumina/widgets/group_home_select_list.dart';

class TabHome extends StatefulWidget{
  @override
  TabHomeState createState() => TabHomeState();
}

class TabHomeState extends State<TabHome>{

  int selectedIndex = 0;
  final widgetOptions = [
    Container(
      width: 120,
      height: 60,
      child: Image.asset('assets/images/logo.png',),
    ),
    Text('Schedule'),
    Text('Groups'),
    Text('Settings'),
    Text('Account'),
  ];

  final screenOptions = [
    HomeMain(),
    Tab_Schedule(),
    Tab_Group(),
    Tab_Setting(),
    Tab_Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widgetOptions.elementAt(selectedIndex),
        actions: [
          selectedIndex == 1
              ? IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GroupHomeSelectList(isDevice: false, isState: "schedule",)));
                  },
                )
              : selectedIndex == 2
                ? IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GroupHomeSelectList(isDevice: false, isState: "group",)));
                  },
                )
                : Container()
        ],
      ),
      body: Center(
        child: screenOptions.elementAt(selectedIndex),
      ),
      floatingActionButton:  selectedIndex == 0
        ? FloatingActionButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => GroupHomeSelectList(isDevice: true, isState: "device",),
                  )
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
        )
        : Container(),
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue,
            primaryColor: Colors.white,
            textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.grey[400]))
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.schedule), title: Text('Schedule')),
            BottomNavigationBarItem(icon: Icon(Icons.group), title: Text('Groups')),
            BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Account'))
          ],
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
      )
    );
  }

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }
}
