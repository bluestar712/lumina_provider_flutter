import 'package:flutter/material.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/schedule_models/schedule.dart';
import 'package:lumina/widgets/schedule_list_item.dart';

class ScheduleList extends StatelessWidget {

  final List<Device> devices;
  final int index;
  final String title;

  ScheduleList({@required this.devices, this.index, this.title});

  @override
  Widget build(BuildContext context) {
    return ScheduleListItem(
      schedule: devices[index].schedule,
      itemnumber: index,
      title: title,
    );
  }
}
