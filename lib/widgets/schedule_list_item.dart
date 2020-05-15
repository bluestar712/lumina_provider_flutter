import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lumina/models/schedule_models/schedule.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/schedule_model.dart';
import 'package:lumina/screens/schedule_sunrise.dart';
import 'package:lumina/screens/schedule_sunset.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ScheduleListItem extends StatefulWidget {

  final Schedule schedule;
  final int itemnumber;
  final String title;

  ScheduleListItem({@required this.schedule, this.itemnumber, this.title});

  @override
  _ScheduleListItemState createState() => _ScheduleListItemState(schedule, itemnumber, title);
}

class _ScheduleListItemState extends State<ScheduleListItem> {

  Schedule _schedule;
  int index;
  String title;

  _ScheduleListItemState(Schedule schedule, int i, String title){
    this._schedule = schedule;
    this.index = i;
    this.title = title;
  }

  final _datetime = DateTime.now();
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  DateTime _selectOntime;
  DateTime _selectOfftime;

  final themeColor = Color(0xfff5a623);
  final primaryColor = Color(0xff203152);

  String sunset;
  List<String> sunrise;

  final values = List.filled(7, false);

  @override
  void initState() {
    _selectOntime = DateTime(_datetime.year, _datetime.month, _datetime.day, 6, 0, 0, 0, 0);
    _selectOfftime = DateTime(_datetime.year, _datetime.month, _datetime.day, 22, 0, 0, 0, 0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.teal),),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: WeekdaySelector(
                      selectedFillColor: Colors.indigo,
                      onChanged: (v) {
                        printIntAsDay(v);
                        setState(() {
                          _schedule.day[v % 7] = !_schedule.day[v % 7];
                          //_schedule.day = values;
                        });
                      },
                      selectedElevation: 15,
                      elevation: 5,
                      disabledElevation: 0,
                      values: _schedule.day,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: () {
                              openDialog_onTime();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "On Time",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                              onLongPress: (){
                                if(_schedule.ontime != "Not set"){
                                  openDialog_deleteOnTime();
                                }
                              },
                              child: Card(
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    _schedule.ontime,
                                    style: TextStyle(color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0
                                    ),
                                  ),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: () {
                              openDialog_offTime();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Off Time",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                              onLongPress: (){
                                if(_schedule.offtime != "Not set"){
                                  openDialog_deleteOffTime();
                                }
                              },
                              child: Card(
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    _schedule.offtime,
                                    style: TextStyle(color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),
                                  ),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleSunrise(index: index,)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Sunrise Time ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: (
                          _schedule.sunrise.map((i) =>
                          GestureDetector(
                            onLongPress: (){

                              setState(() {

                                sunrise = i;

                              });

                              openDialog_Sunrise();
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(i[0].toString())
                                      ),
                                      Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(i[1].toString() + '%')
                                      )
                                    ],
                                  )
                              ),
                            ),
                          )).toList()
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleSunset(itemnumber: index)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Sunset Time ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: (
                          _schedule.sunset.map((i) =>

                              GestureDetector(

                                onLongPress: (){
                                  setState(() {
                                    sunset = i;
                                  });
                                  openDialog_Sunset();
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(i.toString())
                                  ),
                                ),
                              ),
                          ).toList()
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: RaisedButton(
                      onPressed: (){

                        onchangedSave();
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xff374abe), Color(0xff64b6ff)],
                          begin: Alignment.centerLeft, end: Alignment.centerRight
                          ),
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<Null> openDialog_Sunset() async{
    switch(await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.delete,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Remove Sunset Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Are you sure to remove this time?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Provider.of<DeviceModel>(context, listen: false).deleteSunset(sunset, widget.itemnumber);
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
    )){
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> openDialog_Sunrise() async{
    switch(await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.delete,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Remove Sunrise Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Are you sure to remove this time?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Provider.of<DeviceModel>(context, listen: false).deleteSunrise(sunrise, widget.itemnumber);
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
    )){
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> openDialog_onTime() async{

    switch(await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.access_time,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Select On Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){

                  setState(() {
                    hour = 6;
                    minute = 0;
                  });

                  TimeConverter().then((value){
                    _schedule.ontime = value;
                  });

                  print(_schedule.ontime);

                  Navigator.pop(context, 0);
                },
                child: Container(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: _selectOntime,
                    onDateTimeChanged: (DateTime newDateTime){

                      setState(() {
                        hour = newDateTime.hour;
                        minute = newDateTime.minute;
                      });

                      TimeConverter().then((value){
                        _schedule.ontime = value;
                      });

                      print(_schedule.ontime);

                    },
                    use24hFormat: false,
                    minuteInterval: 1,
                  ),
                )
              ),

            ],
          );
        }
    )){
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> openDialog_offTime() async{

    switch(await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.access_time,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Select Off Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                  onPressed: (){

                    setState(() {
                      hour = 22;
                      minute = 0;
                    });

                    TimeConverter().then((value){
                      _schedule.offtime = value;
                    });

                    print(_schedule.offtime);
                    Navigator.pop(context, 0);
                  },
                  child: Container(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: _selectOfftime,
                      onDateTimeChanged: (DateTime newDateTime){

                        setState(() {
                          hour = newDateTime.hour;
                          minute = newDateTime.minute;
                        });

                        TimeConverter().then((value){
                          _schedule.offtime = value;
                        });

                        print( _schedule.offtime);

                      },
                      use24hFormat: false,
                      minuteInterval: 1,
                    ),
                  )
              ),

            ],
          );
        }
    )){
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> openDialog_deleteOnTime() async{
    switch(await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.delete,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Remove On Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Are you sure to remove this time?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  setState(() {
                    _schedule.ontime = "Not set";
                  });

                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
    )){
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> openDialog_deleteOffTime() async{
    switch(await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: themeColor,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.delete,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Remove Off Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Are you sure to remove this time?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  setState(() {
                    _schedule.offtime = "Not set";
                  });

                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
    )){
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  printIntAsDay(int day) {
    print('Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw '🐞 This should never have happened: $day';
  }

  Future<String> TimeConverter() async{

    String onTime;

    if(hour >= 12){

      int pm_hour = hour % 12;

      if (minute < 10 && pm_hour < 10) {
        onTime = '0${pm_hour} : 0${minute}   PM';
      } else if(minute >= 10 && pm_hour < 10){
        onTime = '0${pm_hour} : ${minute}   PM';
      } else if(minute < 10 && pm_hour >= 10){
        onTime = '${pm_hour} : 0${minute}   PM';
      } else{
        onTime = '${pm_hour} : ${minute}   PM';
      }

    }else{

      if (minute < 10 && hour < 10) {
        onTime = '0${hour % 12} : 0${minute}   AM';
      } else if(minute >= 10 && hour < 10){
        onTime = '0${hour % 12} : ${minute}   AM';
      } else if(minute < 10 && hour >= 10){
        onTime = '${hour % 12} : 0${minute}   AM';
      } else{
        onTime = '${hour % 12} : ${minute}   AM';
      }

    }

    return onTime;
  }

  void onchangedSave(){

    final Schedule defaultSchedule = Schedule(
      ontime: "Not set",
      offtime: "Not set",
      day: List.filled(7, false),
      sunrise: [],
      sunset: [],
    );

    final Schedule currentSchedule = Schedule(
      ontime: _schedule.ontime,
      offtime: _schedule.offtime,
      day: _schedule.day,
      sunrise: _schedule.sunrise,
      sunset: _schedule.sunset
    );

    if(defaultSchedule != currentSchedule){
      Provider.of<DeviceModel>(context, listen: false).changeSchedule(widget.itemnumber);
    }else{
      Provider.of<DeviceModel>(context, listen: false).reverseSchedule(widget.itemnumber);
    }
  }

}
