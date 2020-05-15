import 'package:flutter/material.dart';

class Schedule{

  List<bool> day;
  String ontime;
  String offtime;
  bool isOn;

  List sunrise;
  List sunset;

  Schedule({@required this.day, this.ontime, this.offtime, this.sunrise, this.sunset, this.isOn});

}