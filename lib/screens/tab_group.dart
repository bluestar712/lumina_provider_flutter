import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_home.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/providers/schedule_model.dart';
import 'package:lumina/providers/setting_model.dart';
import 'package:lumina/widgets/device_list.dart';
import 'package:lumina/widgets/group_device_list.dart';

import 'package:provider/provider.dart';

class Tab_Group extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Consumer< DeviceModel>(
          builder: (context, todos, child) => GroupDeviceList(
              devices: todos.groupDevices,
          ),
        ),
      ),
    );
  }
}

