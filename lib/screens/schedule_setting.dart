import 'package:flutter/material.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/schedule_model.dart';
import 'package:lumina/widgets/schedule_list.dart';

import 'package:provider/provider.dart';

class ScheduleMain extends StatelessWidget {

  final int index;
  final String title;
  ScheduleMain({@required this.index, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Consumer<DeviceModel>(
          builder: (context, todos, child) => ScheduleList(
            devices: todos.allDevices,
            index: index,
            title: title,
          ),
        ),
      ),
    );
  }
}

