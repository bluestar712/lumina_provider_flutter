import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumina/Sign/signIn.dart';
import 'package:lumina/models/profile_models/profile.dart';
import 'package:lumina/providers/devices_model.dart';
import 'package:lumina/providers/group_home_model.dart';
import 'package:lumina/providers/schedule_model.dart';
import 'package:lumina/providers/setting_model.dart';
import 'package:lumina/screens/tab_main.dart';
import 'package:lumina/sign/signup.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      )
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceModel>(create: (context) => DeviceModel()),
        ChangeNotifierProvider<ProfileTimezone>(create: (context) => ProfileTimezone()),
        ChangeNotifierProvider<GroupHomeModel>(create: (context) => GroupHomeModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: SignUpPage(),
      ),
    );
  }
}

