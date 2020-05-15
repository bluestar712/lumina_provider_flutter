import 'package:flutter/material.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/widgets/group_window_select_listitem.dart';
import 'package:provider/provider.dart';

class GroupWindowSelectList extends StatelessWidget {

  final int index_home;
  final int index_room;
  final bool isDevice;
  final String title;
  final String isState;

  GroupWindowSelectList({@required this.index_home, this.index_room, this.isDevice, this.title, this.isState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<GroupHomeModel>(
        builder: (context, todos, child) => GroupWindowSelectListItem(
          group_window: todos.allGroupHomes[index_home].group_room[index_room].group_window,
          index_home: this.index_home,
          index_room: this.index_room,
          isDevice: this.isDevice,
          title: this.title,
          isState: this.isState,
        ),
      ),
    );
  }
}
