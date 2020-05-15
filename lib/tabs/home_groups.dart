import 'package:flutter/material.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/widgets/group_device_list.dart';
import 'package:provider/provider.dart';

class home_groups extends StatelessWidget {

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
