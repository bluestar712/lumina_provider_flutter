import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_window.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:provider/provider.dart';

class AddGroupWindow extends StatefulWidget {

  final bool isEdit;
  final int index_home;
  final int index_room;
  final int index_window;
  final String cur_window_title;

  AddGroupWindow({@required this.index_home, this.index_room, @required this.isEdit, this.index_window, this.cur_window_title});

  @override
  _AddGroupWindowState createState() => _AddGroupWindowState();
}

class _AddGroupWindowState extends State<AddGroupWindow> {

  TextEditingController taskTitleController;

  @override
  void initState() {

    if(widget.isEdit){
      taskTitleController = TextEditingController(text: widget.cur_window_title);
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
            ? Text('Edit Window')
            : Text('Create Window')
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: taskTitleController,
                  maxLength: 10,
                  decoration: InputDecoration(
                      hintText: 'Enter new window name'
                  ),
                ),
              ),
              Container(
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

    final allGroups = Provider.of<GroupHomeModel>(context, listen: false).allGroupHomes;
    List id = [widget.index_home, widget.index_room, allGroups[widget.index_home].group_room[widget.index_room].group_window.length];

    if(textVal.isNotEmpty){
      final Group_Window todo = Group_Window(
        group_window_title: textVal,
        isGroup: false,
        islock: false,
        id: id,
        device: [],
      );
      Provider.of<GroupHomeModel>(context, listen: false).addGroupWindow(todo, widget.index_home, widget.index_room);
      Navigator.pop(context);
    }
  }

  void onEdit(){

    final String textVal = taskTitleController.text;

    if(textVal.isNotEmpty){

      Provider.of<GroupHomeModel>(context, listen: false).EditGroupWindow(textVal, widget.index_home, widget.index_room, widget.index_window);

      Navigator.pop(context);
    }
  }
}
