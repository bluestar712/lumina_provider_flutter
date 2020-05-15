import 'package:flutter/material.dart';
import 'package:lumina/models/home_models/device.dart';

class Group_Window{

  String group_window_title;
  List id;
  List<Device> device;
  bool isGroup;
  bool islock;

  Group_Window({@required this.group_window_title, this.device, this.isGroup, this.islock, this.id});

  void AddGroup(){
    isGroup = !isGroup;
  }

}