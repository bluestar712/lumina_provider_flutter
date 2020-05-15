import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumina/providers/devices_model.dart';

import 'package:provider/provider.dart';

class ScheduleSunrise extends StatefulWidget {
  final int index;

  ScheduleSunrise({@required this.index});

  @override
  _ScheduleSunriseState createState() => _ScheduleSunriseState();
}

class _ScheduleSunriseState extends State<ScheduleSunrise> {


  final _datetime = DateTime.now();
  DateTime _formatedDate;
  String _ontime;
  int hour = 6;
  int minute = 0;

  List<int> _events = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
  int _selectedevents = 10;

  @override
  void initState() {
    _formatedDate = DateTime(_datetime.year, _datetime.month, _datetime.day, 6, 0, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sunrise Time'),
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
                  initialDateTime: _formatedDate,
                  onDateTimeChanged: (DateTime newDateTime){
                    hour = newDateTime.hour;
                    minute = newDateTime.minute;

                    TimeConverter();
                    print(_datetime);
                    print(_ontime);

                  },
                  use24hFormat: false,
                  minuteInterval: 1,
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 170,
                    alignment: Alignment.center,
                    child: Text('Brightness Level :',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        child: Container(
                            height: 50.0,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.teal,
                                ),
                                value: _selectedevents,
                                onChanged: (newvalue) {
                                  setState(() {
                                    _selectedevents = newvalue;
                                  });
                                },
                                items: _events.map((event) {
                                  return DropdownMenuItem(
                                    child: SizedBox(
                                      width: 120.0,
                                      child: new Text(
                                        '$event'+ '%',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    value: event,
                                  );
                                }).toList(),
                              ),
                            )),
                      ))
                ],
              ),
            ),
            Container(
                height: 50.0,
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: RaisedButton(
                  onPressed: () {
                    if(_ontime == null){
                      TimeConverter();
                      onAdd();
                      Navigator.of(context).pop();
                    }else{
                      onAdd();
                      Navigator.of(context).pop();
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
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
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

  void onAdd(){
    List<String> _sunriselist = [];

    _sunriselist.add(_ontime);
    _sunriselist.add(_selectedevents.toString());

    final allDevices = Provider.of<DeviceModel>(context, listen: false).allDevices;

    if(allDevices[widget.index].schedule.sunrise.length != 0){
      Provider.of<DeviceModel>(context, listen: false).deleteSunrisefromIndex(widget.index);
    }

    Provider.of<DeviceModel>(context, listen: false).addSunrise(_sunriselist, widget.index);


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
}
