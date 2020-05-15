import 'package:flutter/material.dart';
import 'package:lumina/models/schedule_models/schedule.dart';
import 'package:lumina/models/setting_models/setting.dart';

class Device{
  Schedule schedule;
  Setting setting;
  String title;
  int index;
  bool isLike;
  bool isGroup;
  double lowervalue = 0.0;
  List id;
  bool isOn;
  bool isScheduleChanged;

  Device({@required this.title, this.isLike = false, this.isGroup, this.lowervalue,
    this.isOn, this.schedule, this.setting, this.id, this.isScheduleChanged, this.index,
  });

  void toggleLike(){
    isLike = !isLike;
  }

}