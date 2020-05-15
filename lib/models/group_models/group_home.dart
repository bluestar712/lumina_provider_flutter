import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_room.dart';

class Group_Home{

  String group_home_title;
  List id;
  bool isGroup;
  bool islock;
  List<Group_Room> group_room;

  Group_Home({this.group_home_title, this.islock, this.isGroup, this.group_room, this.id});

  void AddGroup(){
    isGroup = !isGroup;
  }

}