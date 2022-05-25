import 'dart:async';

import 'package:flutter_run_cat/databases/local_box.dart';

class SettingBox extends LocalBox with ListenableBoxMixin {
  @override
  String get boxID => "SettingBox";

  @override
  Future openBox() async {
    await super.openBox();
  }

  dynamic load(int typeIndex) {
    return box.get(typeIndex);
  }

  Future<bool> update(int typeIndex, Map<String, dynamic> data) async {
    try {
      await box.put(typeIndex, data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
