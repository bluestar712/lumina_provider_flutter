import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/screens/group_device_add.dart';
import 'package:lumina/screens/schedule_setting.dart';
import 'package:provider/provider.dart';

class GroupDeviceSelectListItem extends StatefulWidget {
  final List<Device> devices;
  final int index_home;
  final int index_room;
  final int index_window;
  final bool isDevice;
  final String title;
  final String isState;

  GroupDeviceSelectListItem(
      {@required this.devices,
      this.index_home,
      this.index_room,
      this.index_window,
      this.isDevice,
      this.isState,
      this.title});

  @override
  _GroupDeviceSelectListItemState createState() =>
      _GroupDeviceSelectListItemState();
}

class _GroupDeviceSelectListItemState extends State<GroupDeviceSelectListItem> {
  List<int> indexes = [];

  final themeColor = Color(0xfff5a623);
  final primaryColor = Color(0xff203152);

  int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Device'),
        actions: [
          widget.isDevice
              ? IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddGroupDevice(
                                  isEdit: false,
                                  index_home: widget.index_home,
                                  index_room: widget.index_room,
                                  index_window: widget.index_window,
                                )));
                  },
                )
              : Container()
        ],
      ),
      body: widget.devices.length == 0
          ? Container(
              child: Center(child: Text('Please create new device.')),
            )
          : Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 40.0, top: 40.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.devices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPress: () {
                            i = index;
                            openDialog();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: ListTile(
                                    title: Text(widget.devices[index].title),
                                    leading: Container(
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: widget.isState == "device"
                                        ? InkWell(
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.black,
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddGroupDevice(
                                                              isEdit: true,
                                                              index_home: widget
                                                                  .index_home,
                                                              index_room: widget
                                                                  .index_room,
                                                              index_window: widget
                                                                  .index_window,
                                                              index_device:
                                                                  index,
                                                              cur_device_title:
                                                                  widget
                                                                      .devices[
                                                                          index]
                                                                      .title)));
                                            },
                                          )
                                        : widget.isState == "schedule"
                                            ? InkWell(
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.black,
                                                ),
                                                onTap: () {
                                                  String title = widget.title +
                                                      " / " +
                                                      widget
                                                          .devices[index].title;
                                                  int device_index = widget
                                                      .devices[index].index;
                                                  Add_schedule(index, title);
                                                },
                                              )
                                            : Icon(
                                                Icons.more_vert,
                                                color: Colors.white,
                                              ))),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }

  Future<Null> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
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
                      'Remove Device',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to remove this device?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
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
                          color: primaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  final id = widget.devices[i].id;

                  Provider.of<DeviceModel>(context, listen: false)
                      .deleteDevicefromList(id);

                  Provider.of<GroupHomeModel>(context, listen: false)
                      .deleteGroupDevice(widget.devices[i], widget.index_home,
                          widget.index_room, widget.index_window);

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
                          color: primaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  void Add_schedule(int index, String title) {
    int device_number;
    String device_title = widget.devices[index].title;

    List device_info = [
      widget.index_home,
      widget.index_room,
      widget.index_window,
      device_title
    ];

    print(device_info);

    Provider.of<DeviceModel>(context, listen: false)
        .getDeviceindex(device_info)
        .then((value) {
      device_number = value;
      print(value);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ScheduleMain(index: device_number, title: title)));
    });
  }
}
