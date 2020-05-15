import 'package:flutter/material.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/widgets/group_room_select_listitem.dart';
import 'package:provider/provider.dart';

class GroupRoomSelectList extends StatelessWidget {

  final int index;
  final bool isDevice;
  final String title;
  final String isState;

  GroupRoomSelectList({@required this.index, this.isDevice, this.title, this.isState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Consumer<GroupHomeModel>(
          builder: (context, todos, child) => GroupRoomSelectListItem(
            group_room: todos.allGroupHomes[index].group_room,
            isDevice: this.isDevice,
            index_home: this.index,
            title: this.title,
            isState: this.isState,
          ),
        ),
      ),
    );
  }
}
