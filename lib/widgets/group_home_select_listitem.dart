import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_home.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/schedule_models/schedule.dart';
import 'package:lumina/models/setting_models/setting.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/screens/group_home_add.dart';
import 'package:lumina/screens/schedule_setting.dart';
import 'package:lumina/widgets/group_room_select_list.dart';
import 'package:provider/provider.dart';

class GroupHomeSelectListItem extends StatefulWidget {
  final List<Group_Home> group_home;
  final bool isDevice;
  final String isState;

  GroupHomeSelectListItem(
      {@required this.group_home, this.isDevice, this.isState});

  @override
  _GroupHomeSelectListItemState createState() =>
      _GroupHomeSelectListItemState();
}

class _GroupHomeSelectListItemState extends State<GroupHomeSelectListItem> {
  List<int> indexes = [];

  final themeColor = Color(0xfff5a623);
  final primaryColor = Color(0xff203152);

  int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Home'),
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
                              builder: (context) => AddGroupHome(
                                    isEdit: false,
                                  )));
                    },
                  )
                : Container()
          ],
        ),
        body: widget.group_home.length == 0
            ? Container(
                child: Center(
                  child: Text('Please create new home.'),
                )
              )
            : widget.isState == "group"
                ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                  child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 400,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.group_home.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        i = index;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupRoomSelectList(
                                                      index: i,
                                                      isDevice: widget.isDevice,
                                                      title: widget
                                                          .group_home[index]
                                                          .group_home_title,
                                                      isState: widget.isState,
                                                    )));
                                      },
                                      onLongPress: () {
                                        i = index;

                                        if (i == widget.group_home.length - 1) {
                                          openDialog();
                                        }
                                      },
                                      child: Container(
                                        child: Card(
                                            semanticContainer: true,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: ListTile(
                                                title: Text(widget
                                                    .group_home[index]
                                                    .group_home_title),
                                                leading: widget.isState != "group"
                                                    ? Container(
                                                        child: Icon(
                                                          Icons.home,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        child: widget
                                                                .group_home[index]
                                                                .isGroup
                                                            ? Icon(
                                                                Icons.group,
                                                                color:
                                                                    Colors.black,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .check_box_outline_blank,
                                                                color:
                                                                    Colors.black,
                                                              ),
                                                        onTap: () {
                                                          if (!widget
                                                              .group_home[index]
                                                              .islock) {
                                                            Provider.of<GroupHomeModel>(
                                                                    context,
                                                                    listen: false)
                                                                .toggleGroupHome(
                                                                    widget.group_home[
                                                                        index]);

                                                            if (widget
                                                                .group_home[index]
                                                                .isGroup) {
                                                              indexes.add(index);
                                                            } else {
                                                              indexes
                                                                  .remove(index);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                trailing: widget.isState ==
                                                        'device'
                                                    ? InkWell(
                                                        child: Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color: Colors.black,
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AddGroupHome(
                                                                            isEdit:
                                                                                true,
                                                                            cur_title: widget
                                                                                .group_home[index]
                                                                                .group_home_title,
                                                                            index:
                                                                                index,
                                                                          )));
                                                        },
                                                      )
                                                    : widget.isState == 'schedule'
                                                        ? widget.group_home[index]
                                                                .islock
                                                            ? InkWell(
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_right,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                onTap: () {
                                                                  String title = widget
                                                                      .group_home[
                                                                          index]
                                                                      .group_home_title;
                                                                  Add_schedule(
                                                                      index,
                                                                      title);
                                                                },
                                                              )
                                                            : Icon(
                                                                Icons.more_vert,
                                                                color:
                                                                    Colors.white,
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
                                ? Container()
                                : widget.isState == "schedule"
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: 30.0, bottom: 10.0),
                                        child: RaisedButton(
                                          onPressed: () {
                                            Add_group_home();
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
                                                  maxWidth: 200.0,
                                                  minHeight: 50.0),
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
                      ),
                    ),
                )
                : Container(
                   padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.group_home.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            i = index;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GroupRoomSelectList(
                                          index: i,
                                          isDevice: widget.isDevice,
                                          title: widget
                                              .group_home[index]
                                              .group_home_title,
                                          isState: widget.isState,
                                        )));
                          },
                          onLongPress: () {
                            i = index;

                            if (i == widget.group_home.length - 1) {
                              openDialog();
                            }
                          },
                          child: Container(
                            child: Card(
                                semanticContainer: true,
                                clipBehavior:
                                Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0)),
                                child: ListTile(
                                    title: Text(widget
                                        .group_home[index]
                                        .group_home_title),
                                    leading: widget.isState != "group"
                                        ? Container(
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.black,
                                      ),
                                    )
                                        : InkWell(
                                      child: widget
                                          .group_home[index]
                                          .isGroup
                                          ? Icon(
                                        Icons.group,
                                        color:
                                        Colors.black,
                                      )
                                          : Icon(
                                        Icons
                                            .check_box_outline_blank,
                                        color:
                                        Colors.black,
                                      ),
                                      onTap: () {
                                        if (!widget
                                            .group_home[index]
                                            .islock) {
                                          Provider.of<GroupHomeModel>(
                                              context,
                                              listen: false)
                                              .toggleGroupHome(
                                              widget.group_home[
                                              index]);

                                          if (widget
                                              .group_home[index]
                                              .isGroup) {
                                            indexes.add(index);
                                          } else {
                                            indexes
                                                .remove(index);
                                          }
                                        }
                                      },
                                    ),
                                    trailing: widget.isState ==
                                        'device'
                                        ? InkWell(
                                      child: Icon(
                                        Icons
                                            .keyboard_arrow_right,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    AddGroupHome(
                                                      isEdit:
                                                      true,
                                                      cur_title: widget
                                                          .group_home[index]
                                                          .group_home_title,
                                                      index:
                                                      index,
                                                    )));
                                      },
                                    )
                                        : widget.isState == 'schedule'
                                        ? widget.group_home[index]
                                        .islock
                                        ? InkWell(
                                      child: Icon(
                                        Icons
                                            .keyboard_arrow_right,
                                        color: Colors
                                            .black,
                                      ),
                                      onTap: () {
                                        String title = widget
                                            .group_home[
                                        index]
                                            .group_home_title;
                                        Add_schedule(
                                            index,
                                            title);
                                      },
                                    )
                                        : Icon(
                                      Icons.more_vert,
                                      color:
                                      Colors.white,
                                    )
                                        : Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ))),
                          ),
                        );
                      }),
        )
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
                      'Remove Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to remove this home?',
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
                  Provider.of<GroupHomeModel>(context, listen: false)
                      .deleteGroupHome(widget.group_home[i]);

                  Delete_HomeDevice(i);

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

  void Delete_HomeDevice(int home_id) {
    Provider.of<DeviceModel>(context, listen: false)
        .deleteHomefromList(home_id)
        .then((value) {
      if (value != null) {
        try {
          Delete_HomeDevice(home_id);
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void Add_group_home() {
    if (indexes.length != 0) {
      for (int i = 0; i < indexes.length; i++) {
        List group_home_id = [indexes[i]];

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
          title: widget.group_home[indexes[i]].group_home_title,
          isLike: false,
          lowervalue: 0.0,
          isGroup: true,
          isOn: false,
          schedule: schedule,
          id: group_home_id,
          setting: setting,
          index: index,
          isScheduleChanged: false,
        );

        Provider.of<DeviceModel>(context, listen: false).addDevice(todo);
        Provider.of<GroupHomeModel>(context, listen: false)
            .allGroupHomes[indexes[i]]
            .islock = true;
      }
    }
  }

  void Add_schedule(int index, String title) {
    int device_number;
    String home_title = widget.group_home[index].group_home_title;

    List device_info = [home_title];

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
