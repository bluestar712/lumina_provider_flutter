import 'package:flutter/material.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/setting_models/setting.dart';
import 'package:lumina/widgets/schedule_list_item.dart';
import 'package:lumina/widgets/setting_list_item.dart';

class SettingList extends StatelessWidget {

  final List<Device> devices;
  final int index;
  final String title;

  SettingList({@required this.devices, this.index, this.title});

  @override
  Widget build(BuildContext context) {
    return SettingListItem(
      device: devices[index],
      itemnumber: index,
      title: title,
    );
  }
}
