import 'dart:collection';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/schedule_models/schedule.dart';

class DeviceModel extends ChangeNotifier{

  final List<Device> _devices = [];

  UnmodifiableListView<Device> get allDevices => UnmodifiableListView(_devices);

  UnmodifiableListView<Device> get realDevices =>
      UnmodifiableListView(_devices.where((todo) => !todo.isGroup));

  UnmodifiableListView<Device> get likeDevices =>
      UnmodifiableListView(_devices.where((todo) => todo.isLike));

  UnmodifiableListView<Device> get groupDevices =>
      UnmodifiableListView(_devices.where((todo) => todo.isGroup));

  UnmodifiableListView<Device> get scheduleDevices =>
      UnmodifiableListView(_devices.where((todo) => todo.isScheduleChanged));

  void addDevice(Device device){
    _devices.add(device);
    notifyListeners();
  }

  void toggleDevice(Device device){
    final deviceIndex = _devices.indexOf(device);
    _devices[deviceIndex].toggleLike();
    notifyListeners();
  }


  void deleteDevicefromList(List device_id){

    int device_index;

    for (int i = 0; i < _devices.length; i ++){
      if(listEquals(_devices[i].id, device_id)){
        device_index = i;
        break;
      }
    }

    _devices.removeAt(device_index);
    notifyListeners();
  }

  Future <int> deleteWindowfromList(List window_id) async{

    List<int> device_indexes = [];

    for(int i = 0; i < _devices.length; i ++){

      if(_devices[i].id[0] == window_id[0]){
        if(_devices[i].id[1] == window_id[1]){
          if(_devices[i].id[2] == window_id[2]){
            device_indexes.add(i);
          }
        }
      }
    }

    print(device_indexes.length);
    print(device_indexes);

    if(device_indexes.length != 0){
      _devices.removeAt(device_indexes[0]);
      notifyListeners();
    }

    if(device_indexes.length != 0){
      return device_indexes[0];
    }else{
      return null;
    }
  }

  Future <int> deleteRoomformList(List room_id) async{

    List<int> device_indexes = [];

    for (int i = 0; i < _devices.length; i ++){
      if(_devices[i].id[0] == room_id[0]){
        if(_devices[i].id[1] == room_id[1]){
          device_indexes.add(i);
        }
      }
    }

    print(device_indexes.length);
    print(device_indexes);

    if(device_indexes.length != 0){
      _devices.removeAt(device_indexes[0]);
      notifyListeners();
    }

    if(device_indexes.length != 0){
      return device_indexes[0];
    }else{
      return null;
    }
  }

  Future<int> deleteHomefromList(int home_id) async{
    List<int> device_indexes = [];

    for(int i = 0; i < _devices.length; i ++){
      if(_devices[i].id[0] == home_id){
        device_indexes.add(i);
      }
    }

    print(device_indexes.length);
    print(device_indexes);

    if(device_indexes.length != 0){
      _devices.removeAt(device_indexes[0]);
      notifyListeners();
    }

    if(device_indexes.length != 0){
      return device_indexes[0];
    }else{
      return null;
    }
  }


  void deleteDevice(Device device){

    _devices.remove(device);
    notifyListeners();
  }

  void addSunset(String sunset, int i_device){
    allDevices[i_device].schedule.sunset.add(sunset);
    notifyListeners();
  }

  void deleteSunset(String sunset, int i_device){
    allDevices[i_device].schedule.sunset.remove(sunset);
    notifyListeners();
  }

  void addSunrise(List<String> sunrise, int i_device){
    allDevices[i_device].schedule.sunrise.add(sunrise);
    notifyListeners();
  }

  void deleteSunrise(List<String> sunrise, int i_device){
    allDevices[i_device].schedule.sunrise.remove(sunrise);
    notifyListeners();
  }

  void deleteSunrisefromIndex(int i_device){
    allDevices[i_device].schedule.sunrise.removeAt(0);
    notifyListeners();
  }

  void deleteSunsetfromIndex(int i_device){
    allDevices[i_device].schedule.sunset.removeAt(0);
    notifyListeners();
  }


  //========== get device index order part ============

  Future<int> getDeviceindex(List device_info) async{

    int device_index;

    int length = device_info.length;

    switch(length){

      case 4:
        for(int i = 0; i < _devices.length ; i ++){
          if(_devices[i].id[0] == device_info[0]){
            if(_devices[i].id[1] == device_info[1]){
              if(_devices[i].id[2] == device_info[2]){
                if(_devices[i].title == device_info[3]){
                  device_index = i;
                  break;
                }
              }
            }
          }
        }
        return device_index;
        break;

      case 3:
        for(int i = 0; i < _devices.length ; i ++){
          if(_devices[i].id[0] == device_info[0]){
            if(_devices[i].id[1] == device_info[1]){
              if(_devices[i].title == device_info[2]){
                device_index = i;
                break;
              }
            }
          }
        }
        return device_index;
        break;

      case 2:
        for(int i = 0; i < _devices.length; i++){

          if(_devices[i].id[0] == device_info[0]){

            if(_devices[i].title == device_info[1]){
              device_index = i;
              break;
            }
          }
        }
        return device_index;
        break;

      case 1:
        for(int i = 0; i < _devices.length; i ++){
          if(_devices[i].title == device_info[0]){
            device_index = i;
            break;
          }
        }
        return device_index;
        break;
    }

  }

  //========== add schedule =======

  void changeSchedule(int i_device){
    allDevices[i_device].isScheduleChanged = true;
    notifyListeners();
  }

  void reverseSchedule(int i_device){
    final Schedule schedule = Schedule(
      ontime: "Not set",
      offtime: "Not set",
      day: List.filled(7, false),
      sunrise: [],
      sunset: [],
    );

    allDevices[i_device].isScheduleChanged = false;

    allDevices[i_device].schedule = schedule;

    notifyListeners();
  }

  Future<int> correspond_devNumber(List id) async{
    int correctNumber;

    for(int i = 0; i < _devices.length; i ++){
      if(listEquals(_devices[i].id, id)){
        correctNumber = i;
        break;
      }
    }

    return correctNumber;
  }

}

