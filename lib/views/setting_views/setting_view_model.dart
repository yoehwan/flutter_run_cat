import 'package:flutter/material.dart';
import 'package:flutter_run_cat/controllers/controllers.dart';
import 'package:tuple/tuple.dart';

class SettingViewModel {
  final SettingController settingController = SettingController.find();

  late TabController tabController;

  final List<Tuple2<IconData, String>> iconList = [
    const Tuple2(Icons.settings, "General"),
    const Tuple2(Icons.run_circle, "System"),
  ];
  int get menuLength => iconList.length;
  void init(TickerProvider vsync) {
    tabController = TabController(
      length: menuLength,
      vsync: vsync,
    );
  }

  void onTapClose() {
    settingController.hideWindow();
  }

  int menuIndex = 0;

  void onTapMenu(int index) {
    menuIndex = index;
  }
}