import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_window.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/schedule_models/schedule.dart';
import 'package:lumina/models/setting_models/setting.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/screens/group_device_add.dart';
import 'package:lumina/screens/group_window_add.dart';
import 'package:lumina/screens/schedule_setting.dart';
import 'package:lumina/widgets/group_device_select_list.dart';
import 'package:provider/provider.dart';

class GroupWindowSelectListItem extends StatefulWidget {
  final List<Group_Window> group_window;
  final int index_home;
  final int index_room;
  final bool isDevice;
  final String title;
  final String isState;

  GroupWindowSelectListItem(
      {@required this.group_window,
      this.index_home,
      this.index_room,
      this.isDevice,
      this.title,
      this.isState});

  @override
  _GroupWindowSelectListItemState createState() =>
      _GroupWindowSelectListItemState();
}

class _GroupWindowSelectListItemState extends State<GroupWindowSelectListItem> {
  List<int> indexes = [];

  final themeColor = Color(0xfff5a623);
  final primaryColor = Color(0xff203152);

  int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Window'),
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
                              builder: (context) => AddGroupWindow(
                                    isEdit: false,
                                    index_home: widget.index_home,
                                    index_room: widget.index_room,
                                  )));
                    },
                  )
                : Container()
          ],
        ),
        body: widget.group_window.length == 0
            ? Container(
                child: Center(child: Text('Please create new window.')),
              )
            : widget.isState == "group"
                ? SingleChildScrollView(
                  child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 400,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.group_window.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GroupDeviceSelectList(
                                                  index_home: widget.index_home,
                                                  index_room: widget.index_room,
                                                  index_window: index,
                                                  isDevice: widget.isDevice,
                                                  title: widget.title +
                                                      ' / ' +
                                                      widget.group_window[index]
                                                          .group_window_title,
                                                  isState: widget.isState,
                                                )));
                                  },
                                  onLongPress: () {
                                    i = index;

                                    if (i == widget.group_window.length - 1) {
                                      openDialog();
                                    }
                                  },
                                  child: Container(
                                    child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: ListTile(
                                            title: Text(widget.group_window[index]
                                                .group_window_title),
                                            leading: widget.isState != "group"
                                                ? Container(
                                                    child: Icon(
                                                      Icons.home,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : InkWell(
                                                    child: widget
                                                            .group_window[index]
                                                            .isGroup
                                                        ? Icon(
                                                            Icons.group,
                                                            color: Colors.black,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: Colors.black,
                                                          ),
                                                    onTap: () {
                                                      if (!widget
                                                          .group_window[index]
                                                          .islock) {
                                                        Provider.of<GroupHomeModel>(
                                                                context,
                                                                listen: false)
                                                            .toggleGroupWindow(
                                                                widget.group_window[
                                                                    index],
                                                                widget.index_home,
                                                                widget
                                                                    .index_room);

                                                        if (widget
                                                            .group_window[index]
                                                            .isGroup) {
                                                          indexes.add(index);
                                                        } else {
                                                          indexes.remove(index);
                                                        }
                                                      }
                                                    },
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
                                                              builder: (context) => AddGroupWindow(
                                                                  isEdit: true,
                                                                  index_home: widget
                                                                      .index_home,
                                                                  index_room: widget
                                                                      .index_room,
                                                                  index_window:
                                                                      index,
                                                                  cur_window_title: widget
                                                                      .group_window[
                                                                          index]
                                                                      .group_window_title)));
                                                    },
                                                  )
                                                : widget.isState == "schedule"
                                                    ? widget.group_window[index]
                                                            .islock
                                                        ? InkWell(
                                                            child: Icon(
                                                              Icons
                                                                  .keyboard_arrow_right,
                                                              color: Colors.black,
                                                            ),
                                                            onTap: () {
                                                              String title = widget
                                                                      .title +
                                                                  " / " +
                                                                  widget
                                                                      .group_window[
                                                                          index]
                                                                      .group_window_title;
                                                              Add_schedule(
                                                                  index, title);
                                                            },
                                                          )
                                                        : Icon(
                                                            Icons.more_vert,
                                                            color: Colors.white,
                                                          )
                                                    : Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                      ))),
                                  ),
                                );
                              }),
                        ),
                        widget.isDevice
                            ? SizedBox(
                                height: 80,
                              )
                            : widget.isState == "schedule"
                                ? SizedBox(
                                    height: 80,
                                  )
                                : Container(
                                    margin:
                                        EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Add_group_window();
                                        Navigator.pop(context);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xff374abe),
                                                  Color(0xff64b6ff)
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight),
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 200.0, minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Add Group',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                      ],
                    ),
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
                            itemCount: widget.group_window.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GroupDeviceSelectList(
                                                index_home: widget.index_home,
                                                index_room: widget.index_room,
                                                index_window: index,
                                                isDevice: widget.isDevice,
                                                title: widget.title +
                                                    ' / ' +
                                                    widget.group_window[index]
                                                        .group_window_title,
                                                isState: widget.isState,
                                              )));
                                },
                                onLongPress: () {
                                  i = index;

                                  if (i == widget.group_window.length - 1) {
                                    openDialog();
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: ListTile(
                                          title: Text(widget.group_window[index]
                                              .group_window_title),
                                          leading: widget.isState != "group"
                                              ? Container(
                                                  child: Icon(
                                                    Icons.home,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : InkWell(
                                                  child: widget
                                                          .group_window[index]
                                                          .isGroup
                                                      ? Icon(
                                                          Icons.group,
                                                          color: Colors.black,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .check_box_outline_blank,
                                                          color: Colors.black,
                                                        ),
                                                  onTap: () {
                                                    if (!widget
                                                        .group_window[index]
                                                        .islock) {
                                                      Provider.of<GroupHomeModel>(
                                                              context,
                                                              listen: false)
                                                          .toggleGroupWindow(
                                                              widget.group_window[
                                                                  index],
                                                              widget.index_home,
                                                              widget
                                                                  .index_room);

                                                      if (widget
                                                          .group_window[index]
                                                          .isGroup) {
                                                        indexes.add(index);
                                                      } else {
                                                        indexes.remove(index);
                                                      }
                                                    }
                                                  },
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
                                                            builder: (context) => AddGroupWindow(
                                                                isEdit: true,
                                                                index_home: widget
                                                                    .index_home,
                                                                index_room: widget
                                                                    .index_room,
                                                                index_window:
                                                                    index,
                                                                cur_window_title: widget
                                                                    .group_window[
                                                                        index]
                                                                    .group_window_title)));
                                                  },
                                                )
                                              : widget.isState == "schedule"
                                                  ? widget.group_window[index]
                                                          .islock
                                                      ? InkWell(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_right,
                                                            color: Colors.black,
                                                          ),
                                                          onTap: () {
                                                            String title = widget
                                                                    .title +
                                                                " / " +
                                                                widget
                                                                    .group_window[
                                                                        index]
                                                                    .group_window_title;
                                                            Add_schedule(
                                                                index, title);
                                                          },
                                                        )
                                                      : Icon(
                                                          Icons.more_vert,
                                                          color: Colors.white,
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
                  ));
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
                      'Remove Window',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to remove this window?',
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
                  final List window_id = [
                    widget.index_home,
                    widget.index_room,
                    i
                  ];

                  Provider.of<GroupHomeModel>(context, listen: false)
                      .deleteGroupWindow(widget.group_window[i],
                          widget.index_home, widget.index_room);

                  Delete_WindowDevice(window_id);

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

  void Delete_WindowDevice(List window_id) {
    Provider.of<DeviceModel>(context, listen: false)
        .deleteWindowfromList(window_id)
        .then((value) {
      if (value != null) {
        try {
          Delete_WindowDevice(window_id);
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void Add_group_window() {
    if (indexes.length != 0) {
      for (int i = 0; i < indexes.length; i++) {
        List group_window_id = [
          widget.index_home,
          widget.index_room,
          indexes[i]
        ];
        int index =
            Provider.of<DeviceModel>(context, listen: false).allDevices.length;
        print(index);

        final Schedule schedule = Schedule(
          ontime: "Not set",
          offtime: "Not set",
          day: List.filled(7, false),
          isOn: false,
          sunrise: [],
          sunset: [],
        );

        final Setting setting = Setting(
          device1: 0.0,
          device2: 0.0,
          device3: 0.0,
          device4: 0.0,
          device5: 0.0,
          device6: 0.0,
          device7: 0.0,
          device8: 0.0,
        );

        final Device todo = Device(
          title: widget.group_window[indexes[i]].group_window_title,
          isLike: false,
          lowervalue: 0.0,
          isGroup: true,
          isOn: false,
          schedule: schedule,
          id: group_window_id,
          setting: setting,
          index: index,
          isScheduleChanged: false,
        );

        Provider.of<DeviceModel>(context, listen: false).addDevice(todo);
        Provider.of<GroupHomeModel>(context, listen: false)
            .allGroupHomes[widget.index_home]
            .group_room[widget.index_room]
            .group_window[indexes[i]]
            .islock = true;
      }
    }
  }

  void Add_schedule(int index, String title) {
    int device_number;
    String window_title = widget.group_window[index].group_window_title;

    List device_info = [widget.index_home, widget.index_room, index];

    Provider.of<DeviceModel>(context, listen: false)
        .correspond_devNumber(device_info)
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
