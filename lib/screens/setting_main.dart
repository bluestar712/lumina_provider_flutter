import 'package:flutter/material.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/schedule_model.dart';
import 'package:lumina/providers/setting_model.dart';
import 'package:lumina/widgets/schedule_list.dart';
import 'package:lumina/widgets/setting_list.dart';

import 'package:provider/provider.dart';

class SettingMain extends StatelessWidget {

  final int index;
  final String title;
  SettingMain({@required this.index, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Consumer<DeviceModel>(
          builder: (context, todos, child) => SettingList(
            devices: todos.realDevices,
            index: index,
            title: title,
          ),
        ),
      ),
    );
  }
}

