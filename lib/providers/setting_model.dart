import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lumina/models/setting_models/setting.dart';


class SettingModel extends ChangeNotifier{

  final List<Setting> _settings = [];

  UnmodifiableListView<Setting> get allSettings => UnmodifiableListView(_settings);

  void addSetting(Setting setting){
    _settings.add(setting);
    notifyListeners();
  }

  void deleteSetting(Setting setting){
    _settings.remove(setting);
    notifyListeners();
  }

}

