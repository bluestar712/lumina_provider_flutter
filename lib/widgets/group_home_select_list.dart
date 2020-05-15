import 'package:flutter/material.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/widgets/group_home_select_listitem.dart';
import 'package:provider/provider.dart';

class GroupHomeSelectList extends StatelessWidget {

  final bool isDevice;
  final String isState;
  GroupHomeSelectList({@required this.isDevice, @required this.isState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Consumer<GroupHomeModel>(
          builder: (context, todos, child) => GroupHomeSelectListItem(
            group_home: todos.allGroupHomes,
            isDevice: this.isDevice,
            isState: this.isState,
          )
        ),
      ),
    );
  }
}
