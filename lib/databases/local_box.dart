library local_box;

import 'dart:async';

import 'package:flutter_run_cat/consts.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'setting_box.dart';

abstract class LocalBox {
  static Future init() async {
    await Hive.initFlutter(dbPath);
  }

  String get boxID;
  late Box box;

  Future openBox() async {
    box = await Hive.openBox(boxID);

    // await box.clear();
  }

  Future closebox() async {
    await box.close();
  }

  Future clearBox() async {
    await box.clear();
  }
}
