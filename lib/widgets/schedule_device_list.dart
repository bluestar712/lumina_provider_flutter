import 'dart:io';

import 'package:custom_switch/custom_switch.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/screens/schedule_setting.dart';
import 'package:provider/provider.dart';

class ScheduleDeviceList extends StatefulWidget {

  final List<Device> devices;

  ScheduleDeviceList({@required this.devices});

  _ScheduleDeviceListState createState() => _ScheduleDeviceListState();

}

class _ScheduleDeviceListState extends State<ScheduleDeviceList>{

  ScrollController _rrectController = ScrollController();
  final themeColor = Color(0xfff5a623);
  final primaryColor = Color(0xff203152);

  int i;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar.semicircle(
      controller: _rrectController,
      backgroundColor: Colors.blue,
      child: ListView.builder(
        controller: _rrectController,
        itemCount: widget.devices.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onLongPress:(){
              setState(() {
                i = index;
              });

              openDialog();
            },
            child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: InkWell(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: index % 4 == 0
                            ? [Color(0xffed742e), Color(0xfff8ea4d)]
                            : index % 4 == 1
                            ? [Color(0xff8339e8), Color(0xff492ac8)]
                            : index % 4 == 2
                            ? [Color(0xffe4437c), Color(0xff5f37f0)]
                            : [Color(0xff367be4), Color(0xff0000ff)],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                      ),
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  child: widget.devices[index].isLike
                                      ? Icon(Icons.star, color: Colors.white)
                                      : Icon(Icons.star_border, color: Colors.white,),
                                  onTap: (){
                                    Provider.of<DeviceModel>(context, listen: false).toggleDevice(widget.devices[index]);
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: FutureBuilder(
                                      future: convert_address(widget.devices[index].id),
                                      builder: (context, snapshot){
                                        return snapshot.data != null
                                            ? Text(
                                          snapshot.data,
                                          style: TextStyle(color: Colors.white),
                                        )
                                            : FutureBuilder(
                                                future: convert_address_dynamic(widget.devices[index].id),
                                                builder: (context, snapshot){
                                                  return snapshot.data != null
                                                      ? Text(
                                                        snapshot.data,
                                                        style: TextStyle(color: Colors.white),
                                                      )
                                                      : Container();
                                          },
                                        );
                                      }
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget.devices[index].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),

                                Container(
                                    child: CustomSwitch(
                                      activeColor: Colors.greenAccent[700],
                                      value: widget.devices[index].schedule.isOn,
                                      onChanged: (value){
                                        print('VALUE: $value');
                                        setState(() {
                                          widget.devices[index].schedule.isOn = value;
                                        });
                                      },
                                    )
                                )
                              ],
                            ),
                          ),
                          widget.devices[index].schedule.ontime.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "On time : ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                        child: Text(widget.devices[index].schedule.ontime,
                                        style: TextStyle(color: Colors.white),)),
                                  ],
                                )
                            )
                            : Container(),
                          widget.devices[index].schedule.offtime.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Off time : ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text(widget.devices[index].schedule.offtime,
                                              style: TextStyle(color: Colors.white))),
                                    ],
                                  )
                              )
                              : Container(),
                          widget.devices[index].schedule.sunrise.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(left: 20.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Container(
                                     child: Text(
                                       "Sunrise time : ",
                                       style: TextStyle(color: Colors.white),
                                     ),
                                   ),
                                   Container(
                                     margin: EdgeInsets.only(left: 10),
                                     child: Text(
                                         widget.devices[index].schedule.sunrise[0][0],
                                       style: TextStyle(color: Colors.white),
                                     ),
                                   ),
                                   Container(
                                     margin: EdgeInsets.only(left: 20.0),
                                     child: Text(
                                       "Brightness : ",
                                       style: TextStyle(color: Colors.white),
                                     ),
                                   ),
                                   Container(
                                     margin: EdgeInsets.only(left: 10),
                                     child: Text(
                                         widget.devices[index].schedule.sunrise[0][1] + "%",
                                         style: TextStyle(color: Colors.white)
                                     ),
                                   )
                                 ],
                               )
                            )
                            : Container(),
                          widget.devices[index].schedule.sunset.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Sunset time : ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          widget.devices[index].schedule.sunset[0],
                                            style: TextStyle(color: Colors.white)
                                        ),
                                      ),
                                    ],
                                  )
                              )
                              : Container(),
                          widget.devices[index].schedule.day.contains(true)
                              ? Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text("Repeat : ", style: TextStyle(color: Colors.white),),
                                    ),
                                    FutureBuilder(
                                        future: convert_day(widget.devices[index].schedule.day),
                                        builder: (context, snapshot){
                                          return snapshot.data != null
                                              ? Text(
                                                snapshot.data,
                                                style: TextStyle(color: Colors.white),
                                              )
                                              : Container();
                                        }
                                    ),
                                  ],
                                ),
                              )
                              : Container()

                        ],
                      ),
                    ),
                  ),
                  onTap: (){

                    if(widget.devices[index].schedule.isOn){
                      move_schedule_item(widget.devices[index].id);
                    }

                  },
                )
            ),
          );
        },
      ),
    );
  }

  Future<Null> openDialog() async{
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
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Remove schedule',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Are you sure to remove this schedule?',
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

                  delete_schedule_item(widget.devices[i].id);

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

  void showAlertDialog(BuildContext context, String content){
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text('Alert'),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
      )
    );
  }

  Future<String> convert_day(List days) async{

    String monday = "";
    String tuesday = "";
    String wednesday = "";
    String thuesday = "";
    String friday = "";
    String saturday = "";
    String sunday = "";


    if(days[0]){
      sunday = "Sun";
    }if(days[1]){
      monday = "Mon, ";
    }if(days[2]){
      tuesday = "Tue, ";
    }if(days[3]){
      wednesday = "Wed, ";
    }if(days[4]){
      thuesday = "Thu, ";
    }if(days[5]){
      friday = "Fri, ";
    }if(days[6]){
      saturday = "Sat, ";
    }

    String Allday =  monday + tuesday + wednesday + thuesday + friday + saturday + sunday;

    return Allday;

  }

  Future<int> move_schedule_item(List id) async{

    final allDevices = Provider.of<DeviceModel>(context, listen: false).allDevices;

    Provider.of<DeviceModel>(context, listen: false).correspond_devNumber(id).then((index){

      print(index);
      print(allDevices[index].id);

      String title = allDevices[index].title;

      Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleMain(index: index, title: title)));

    });
  }

  void delete_schedule_item(List id){

    Provider.of<DeviceModel>(context, listen: false).correspond_devNumber(id).then((index){

      Provider.of<DeviceModel>(context, listen: false).reverseSchedule(index);

    });
  }

  Future<String> convert_address(List id) async{

    int length = id.length;
    String st_home, st_room, st_window;
    final allGroups = Provider.of<GroupHomeModel>(context, listen: false).allGroupHomes;

    switch(length){
      case 4:

        for(int i_home = 0; i_home < allGroups.length; i_home ++){
          for (int i_room = 0; i_room < allGroups[i_home].group_room.length; i_room ++ ){
            for(int i_window = 0; i_window < allGroups[i_home].group_room[i_room].group_window.length; i_window ++){
              for(int i_device = 0; i_device < allGroups[i_home].group_room[i_room].group_window[i_window].device.length; i_device ++){

                List current_id = allGroups[i_home].group_room[i_room].group_window[i_window].device[i_device].id;
                if(listEquals(current_id, id)){

                  st_home = allGroups[i_home].group_home_title;
                  st_room = allGroups[i_home].group_room[i_room].group_room_title;
                  st_window = allGroups[i_home].group_room[i_room].group_window[i_window].group_window_title;
                  break;
                }


              }
            }
          }
        }


        String Address = st_home + " / " + st_room + " / " + st_window;
        return Address;
        break;

      case 3:

        for(int i_home = 0; i_home < allGroups.length; i_home ++){
          for (int i_room = 0; i_room < allGroups[i_home].group_room.length; i_room ++ ){
            for(int i_window = 0; i_window < allGroups[i_home].group_room[i_room].group_window.length; i_window ++){

              List current_id = allGroups[i_home].group_room[i_room].group_window[i_window].id;

              if(listEquals(current_id, id)){

                st_home = allGroups[i_home].group_home_title;
                st_room = allGroups[i_home].group_room[i_room].group_room_title;
                break;
              }


            }
          }
        }


        String Address = st_home + " / " + st_room;
        return Address;
        break;

      case 2:

        for(int i_home = 0; i_home < allGroups.length; i_home ++){
          for (int i_room = 0; i_room < allGroups[i_home].group_room.length; i_room ++ ){

            List current_id = allGroups[i_home].group_room[i_room].id;

            if(listEquals(current_id, id)){

              st_home = allGroups[i_home].group_home_title;
              break;
            }


          }
        }

        String Address = st_home;
        return Address;
        break;

    }

  }

  Future<String> convert_address_dynamic(List id) async{

    int length = id.length;

    switch(length){
      case 4:

        int i_home = id[0];
        int i_room = id[1];
        int i_window = id[2];

        final allGroups = Provider.of<GroupHomeModel>(context, listen: false).allGroupHomes;

        String st_home = allGroups[i_home].group_home_title;
        String st_room = allGroups[i_home].group_room[i_room].group_room_title;
        String st_window = allGroups[i_home].group_room[i_room].group_window[i_window].group_window_title;

        String Address = st_home + " / " + st_room + " / " + st_window;
        return Address;
        break;

      case 3:

        int i_home = id[0];
        int i_room = id[1];


        final allGroups = Provider.of<GroupHomeModel>(context, listen: false).allGroupHomes;

        String st_home = allGroups[i_home].group_home_title;
        String st_room = allGroups[i_home].group_room[i_room].group_room_title;

        String Address = st_home + " / " + st_room;
        return Address;
        break;

      case 2:

        int i_home = id[0];

        final allGroups = Provider.of<GroupHomeModel>(context, listen: false).allGroupHomes;

        String st_home = allGroups[i_home].group_home_title;

        String Address = st_home;
        return Address;
        break;

    }

  }
}
