import 'package:flutter/material.dart';
import 'package:lumina/models/group_models/group_home.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:provider/provider.dart';

class AddGroupHome extends StatefulWidget {

  final bool isEdit;
  final String cur_title;
  final int index;
  AddGroupHome({@required this.isEdit, this.cur_title, this.index});

  @override
  _AddGroupHomeState createState() => _AddGroupHomeState();
}

class _AddGroupHomeState extends State<AddGroupHome> {

  TextEditingController taskTitleController;

  @override
  void initState() {

    if(widget.isEdit){
      taskTitleController = TextEditingController(text: widget.cur_title);
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
            ? Text('Edit Home')
            : Text('Create Home'),
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
                  maxLength: 15,
                  decoration: InputDecoration(
                    hintText: 'Enter new home name'
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
    List id = [allGroups.length];

    if(textVal.isNotEmpty){
      final Group_Home todo = Group_Home(
        group_home_title: textVal,
        isGroup: false,
        islock: false,
        id: id,
        group_room: [],
      );
      Provider.of<GroupHomeModel>(context, listen: false).addGroupHome(todo);
      Navigator.pop(context);
    }
  }

  void onEdit(){

    final String textVal = taskTitleController.text;

    if(textVal.isNotEmpty){

      Provider.of<GroupHomeModel>(context, listen: false).EditGroupHome(textVal, widget.index);

      Navigator.pop(context);
    }
  }
}
