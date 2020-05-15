import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lumina/models/schedule_models/schedule.dart';


class ScheduleModel extends ChangeNotifier{

  final List<Schedule> _schedules = [];

  UnmodifiableListView<Schedule> get allSchedules => UnmodifiableListView(_schedules);

  void addSchedule(Schedule schedule){
    _schedules.add(schedule);
    notifyListeners();
  }

  void deleteSchedule(Schedule schedule){
    _schedules.remove(schedule);
    notifyListeners();
  }

//  void addSunset(String sunset, int i){
//    allSchedules[i].sunset.add(sunset);
//    notifyListeners();
//  }
//
//  void deleteSunset(String j, int i){
//    allSchedules[i].sunset.remove(j);
//    notifyListeners();
//  }

//  void addSunrise(List<String> sunrise, int i ){
//    allSchedules[i].sunrise.add(sunrise);
//    notifyListeners();
//  }

//  void deleteSunrise(List<String> sunrise, int i){
//    allSchedules[i].sunrise.remove(sunrise);
//    notifyListeners();
//  }

}