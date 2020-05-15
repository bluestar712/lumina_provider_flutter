import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/schedule_model.dart';
import 'package:provider/provider.dart';

class ScheduleSunset extends StatefulWidget {
  final int itemnumber;

  const ScheduleSunset({Key key, this.itemnumber}) : super(key: key);

  @override
  _ScheduleSunsetState createState() => _ScheduleSunsetState();
}

class _ScheduleSunsetState extends State<ScheduleSunset> {

  final _datetime = DateTime.now();
  String _ontime;
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sunset'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30.0, left: 20.0),
                      child: Text('Start Time :', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
              Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 30.0, left: 40.0, right: 40.0),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: _datetime,
                    onDateTimeChanged: (DateTime newDateTime){
                      hour = newDateTime.hour;
                      minute = newDateTime.minute;

                      TimeConverter();

                      print(_ontime);

                    },
                    use24hFormat: false,
                    minuteInterval: 1,
                  )
              ),
              Container(
                  height: 50.0,
                  margin: EdgeInsets.symmetric(vertical: 80.0),
                  child: RaisedButton(
                    onPressed: () {
                      if(_ontime == null){
                        TimeConverter();
                        onAdd();
                      }else{
                        onAdd();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff374abe), Color(0xff64b6ff)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                        BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Add',
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),

    );
  }

  void TimeConverter(){

    if(hour >= 12){

      int pm_hour = hour % 12;

      if (minute < 10 && pm_hour < 10) {
        _ontime = '0${pm_hour} : 0${minute}   PM';
      } else if(minute >= 10 && pm_hour < 10){
        _ontime = '0${pm_hour} : ${minute}   PM';
      } else if(minute < 10 && pm_hour >= 10){
        _ontime = '${pm_hour} : 0${minute}   PM';
      } else{
        _ontime = '${pm_hour} : ${minute}   PM';
      }

    }else{

      if (minute < 10 && hour < 10) {
        _ontime = '0${hour % 12} : 0${minute}   AM';
      } else if(minute >= 10 && hour < 10){
        _ontime = '0${hour % 12} : ${minute}   AM';
      } else if(minute < 10 && hour >= 10){
        _ontime = '${hour % 12} : 0${minute}   AM';
      } else{
        _ontime = '${hour % 12} : ${minute}   AM';
      }

    }
  }

  void onAdd(){

    final allDevices = Provider.of<DeviceModel>(context, listen: false).allDevices;

    if(allDevices[widget.itemnumber].schedule.sunset.length != 0){
      Provider.of<DeviceModel>(context, listen: false).deleteSunsetfromIndex(widget.itemnumber);
    }

    Provider.of<DeviceModel>(context, listen: false).addSunset(_ontime, widget.itemnumber);
    Navigator.of(context).pop();
  }
}
