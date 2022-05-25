library local_box;

import 'dart:async';

import 'package:flutter_run_cat/consts.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef BoxCallback = Function(dynamic index, dynamic value);

abstract class LocalBox {
  static Future init() async {
    await Hive.initFlutter(dbPath);
  }

  String get boxID;
  late Box box;

  Future openBox() async {
    box = await Hive.openBox(boxID);
  }

  Future closebox() async {
    await box.close();
  }

  Future clearBox() async {
    await box.clear();
  }
}

mixin ListenableBoxMixin on LocalBox {
  late StreamSubscription _subscription;
  @override
  Future openBox() async {
    await super.openBox();
    _subscription = box.watch().listen((e) {
      notifyListeners(e.key, e.value);
    });
  }

  void closeBox() {
    _subscription.cancel();
    super.closebox();
  }

  final List<BoxCallback> listenerList = [];

  void addListener(BoxCallback listener) {
    if (listenerList.contains(listener)) return;
    listenerList.add(listener);
  }

  void removeListener(BoxCallback listener) {
    listenerList.remove(listener);
  }

  void notifyListeners(dynamic index, dynamic value) {
    for (final listener in listenerList) {
      listener(index, value);
    }
  }
}
