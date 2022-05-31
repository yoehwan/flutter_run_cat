import 'dart:async';

import 'package:flutter_run_cat/controllers/panel_controller/panel_controller.dart';
import 'package:flutter_run_cat/controllers/tray_controller/tray_controller.dart';
import 'package:flutter_run_cat/controllers/version_controller/version_controller.dart';
import 'package:get/get.dart';

abstract class Controller extends GetxController {
  final Completer _loading = Completer();
  Future get loading => _loading.future;
  @override
  void onInit() {
    /// call [onReady] forcely,
    ///because [SchedulerBinding] didn't called on main.dart.
    /// cannot be triggered.
    onReady();
  }

  @override
  void onReady() {
    _loading.complete();
    super.onReady();
  }
}

Future initControllers() async {
  Get.put(PanelController());
  Get.put(TrayController());
  Get.put(VersionController());
}
