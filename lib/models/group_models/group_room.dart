import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_window.dart';

class Group_Room{

  String group_room_title;
  List id;
  bool isGroup;
  bool islock;
  List<Group_Window> group_window;

  Group_Room({@required this.group_room_title, this.group_window, this.isGroup, this.islock, this.id});

  void AddGroup(){
    isGroup = !isGroup;
  }
}