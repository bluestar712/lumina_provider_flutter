import 'package:flutter/material.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/schedule_models/schedule.dart';
import 'package:lumina/models/setting_models/setting.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:provider/provider.dart';

class AddGroupDevice extends StatefulWidget {

  final bool isEdit;
  final int index_home;
  final int index_room;
  final int index_window;
  final int index_device;
  final String cur_device_title;


  AddGroupDevice({@required this.index_home, this.index_room, this.index_window, @required this.isEdit,
    this.index_device, this.cur_device_title
  });

  @override
  _AddGroupDeviceState createState() => _AddGroupDeviceState();
}

class _AddGroupDeviceState extends State<AddGroupDevice> {

  bool likeStatus = false;
  TextEditingController taskTitleController;

  @override
  void initState() {

    if(widget.isEdit){
      taskTitleController = TextEditingController(text: widget.cur_device_title);
    }else{
      taskTitleController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEdit
            ? Text('Edit Device')
            : Text('Create Device')
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: taskTitleController,
                  maxLength: 15,
                  decoration: InputDecoration(
                      hintText: 'Enter new device name'
                  ),
                ),
              ),
              widget.isEdit
                ? Container()
                : Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0,),
                child: CheckboxListTile(
                  value: likeStatus,
                  onChanged: (checked) => setState((){
                    likeStatus = checked;
                  }),
                  title: Text('Add to Favorites?'),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                  child: RaisedButton(
                    onPressed: () {
                      if(!widget.isEdit){
                        onAdd();
                      }else{
                        onEdit();
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
                        child: widget.isEdit
                            ? Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            )
                            : Text(
                              'Create',
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
    );
  }

  void onAdd(){

    final String textVal = taskTitleController.text;
    int index_device = Provider.of<GroupHomeModel>(context, listen: false).allGroupHomes[widget.index_home].group_room[widget.index_room].group_window[widget.index_window].device.length;
    int index = Provider.of<DeviceModel>(context, listen: false).allDevices.length;

    print(index_device);
    print(index);

    if(textVal.isNotEmpty){

      final List device_id = [widget.index_home, widget.index_room, widget.index_window, index_device];

      print(device_id);

      final Schedule schedule = Schedule(
        ontime: "Not set",
        offtime: "Not set",
        day: List.filled(7, false),
        sunrise: [],
        isOn: false,
        sunset: [],
      );

      final Setting setting = Setting(
        device1: 100.0,
        device2: 100.0,
        device3: 100.0,
        device4: 100.0,
        device5: 100.0,
        device6: 100.0,
        device7: 100.0,
        device8: 100.0,
      );

      final Device todo = Device(
          title: textVal,
          isLike: likeStatus,
          lowervalue: 0.0,
          isGroup: false,
          isOn: false,
          schedule: schedule,
          id: device_id,
          setting: setting,
          index: index,
          isScheduleChanged: false

      );

      Provider.of<GroupHomeModel>(context, listen: false).addGroupDevice(todo, widget.index_home, widget.index_room, widget.index_window);
      Provider.of<DeviceModel>(context, listen: false).addDevice(todo);

      Navigator.pop(context);
    }
  }

  void onEdit(){

    final String textVal = taskTitleController.text;

    if(textVal.isNotEmpty){

      Provider.of<GroupHomeModel>(context, listen: false).EditGroupDevice(textVal, widget.index_home, widget.index_room, widget.index_window, widget.index_device);

      Navigator.pop(context);
    }
  }
}
