import 'package:flutter/material.dart';

class Profile{

  static String firstName = "";
  static String lastName = "";
  static String email = "";
  static String phonenumber = "";
  static String address1 = "";
  static String address2 = "";
  static String city = "";
  static String zipcode = "";
  static String state = "";

}

class ProfileTimezone extends ChangeNotifier{

  String timezone;

  ProfileTimezone({this.timezone});

  getProfileTimezone () => timezone;
  setProfileTimezone(String time) => timezone = time;

  void changeValue(String time){
    timezone = time;
    notifyListeners();
  }
}