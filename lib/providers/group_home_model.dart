import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_home.dart';
import 'package:lumina/models/group_models/group_room.dart';
import 'package:lumina/models/group_models/group_window.dart';
import 'package:lumina/models/home_models/device.dart';


class GroupHomeModel extends ChangeNotifier{

  final List<Group_Home> _group_homes = [];

  UnmodifiableListView<Group_Home> get allGroupHomes => UnmodifiableListView(_group_homes);

  void addGroupHome(Group_Home group_home){
    _group_homes.add(group_home);
    notifyListeners();
  }

  void addGroupRoom(Group_Room group_room, int i_home){
    allGroupHomes[i_home].group_room.add(group_room);
    notifyListeners();
  }

  void addGroupWindow(Group_Window group_window, int i_home, int i_room){
    allGroupHomes[i_home].group_room[i_room].group_window.add(group_window);
    notifyListeners();
  }

  void addGroupDevice(Device device, int i_home, int i_room, int i_window){
    allGroupHomes[i_home].group_room[i_room].group_window[i_window].device.add(device);
    notifyListeners();
  }

  void deleteGroupDevice(Device device, int i_home, int i_room, int i_window){
    allGroupHomes[i_home].group_room[i_room].group_window[i_window].device.remove(device);
    notifyListeners();
  }

  void deleteGroupDevicefromIndex(int i_home, int i_room, int i_window, int i_device){
    allGroupHomes[i_home].group_room[i_room].group_window[i_window].device.removeAt(i_device);
    notifyListeners();
  }

  void deleteGroupWindow(Group_Window group_window, int i_home, int i_room){
    allGroupHomes[i_home].group_room[i_room].group_window.remove(group_window);
    notifyListeners();
  }

  void deleteGroupRoom(Group_Room group_room, int i_home){
    allGroupHomes[i_home].group_room.remove(group_room);
    notifyListeners();
  }

  void deleteGroupHome(Group_Home group_home){
    _group_homes.remove(group_home);
    notifyListeners();
  }

  void toggleGroupHome(Group_Home group_home){
    final groupIndex = _group_homes.indexOf(group_home);
    _group_homes[groupIndex].AddGroup();
    notifyListeners();
  }

  void toggleGroupRoom(Group_Room group_room, int i_home){
    final groupIndex = allGroupHomes[i_home].group_room.indexOf(group_room);
    allGroupHomes[i_home].group_room[groupIndex].AddGroup();
    notifyListeners();
  }

  void toggleGroupWindow(Group_Window group_window, int i_home, int i_room){
    final groupIndex = allGroupHomes[i_home].group_room[i_room].group_window.indexOf(group_window);
    allGroupHomes[i_home].group_room[i_room].group_window[groupIndex].AddGroup();
    notifyListeners();
  }

  // ========== Edit part ===========

  void EditGroupHome(String home_name, int i_home){
    allGroupHomes[i_home].group_home_title = home_name;
    notifyListeners();
  }

  void EditGroupRoom(String room_name, int i_home, int i_room){
    allGroupHomes[i_home].group_room[i_room].group_room_title = room_name;
    notifyListeners();
  }

  void EditGroupWindow(String window_name, int i_home, int i_room, int i_window){
    allGroupHomes[i_home].group_room[i_room].group_window[i_window].group_window_title = window_name;
    notifyListeners();
  }

  void EditGroupDevice(String device_name, int i_home, int i_room, int i_window, int i_device){
    allGroupHomes[i_home].group_room[i_room].group_window[i_window].device[i_device].title = device_name;
    notifyListeners();
  }


}

