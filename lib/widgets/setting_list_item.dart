import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:lumina/models/home_models/device.dart';
import 'package:lumina/models/setting_models/setting.dart';

class SettingListItem extends StatefulWidget {

  final Device device;
  final int itemnumber;
  final String title;

  SettingListItem({@required this.device, this.itemnumber, this.title});

  @override
  _SettingListItemState createState() => _SettingListItemState(device, itemnumber, title);
}

class _SettingListItemState extends State<SettingListItem> {

  Device _device;
  int index;
  String title;

  _SettingListItemState(Device device, int i, String title){
    this._device = device;
    this.index = i;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calibrate Lumina'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(title, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.teal)),
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device1],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device1 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device2],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device2 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device3],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device3 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('4', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device4],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device4 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device5],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device5 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('6', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device6],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device6 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('7', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device7],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device7 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            alignment: Alignment.center,
                            child: Text('8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                          ),
                          Expanded(
                            child: FlutterSlider(
                              values: [_device.setting.device8],
                              max: 100,
                              min: 0,
                              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                setState(() {
                                  _device.setting.device8 = lowerValue;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
