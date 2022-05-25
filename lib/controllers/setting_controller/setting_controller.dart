import 'dart:ui';

import 'package:flutter_run_cat/consts.dart';
import 'package:flutter_run_cat/controllers/controllers.dart';
import 'package:flutter_run_cat/models/runner/runner.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/utils/setting_helper.dart';
import 'package:flutter_run_cat/utils/window_helper_mixin.dart';
import 'package:get/get.dart';

class SettingController extends Controller with WindonwHelperMixin {
  static SettingController find() => Get.find<SettingController>();

  final SettingHelper _settingHelper = SettingHelper();

  @override
  void onInit() async {
    await _settingHelper.init();
    initWindow(const Size(windowMinWidth, windowMinHeight));
    super.onInit();
  }

  Setting? loadSetting(int typeIndex) {
    return _settingHelper.loadSetting(typeIndex);
  }

  void updateStartUpLaunch(bool value) {
    _settingHelper.updateStartUpLaunch(value);
  }

  List<Runner> loadRunnerList() {
    return _settingHelper.loadRunnerList();
  }

  Future updateRunner(String name, List<String> itemList) async {
     // await _settingHelper.updateRunner(name, itemList);
  }

  /// View
  final String generalViewID = "generalViewID";
  void updateGeneralView() {
    update([generalViewID]);
  }

  final String systemInfoViewID = "systemInfoViewID";

  void updateSystemInfoView() {
    update([systemInfoViewID]);
  }

  final String versionViewID = "versionViewID";

  void updateVersionView() {
    update([versionViewID]);
  }

  Future updateSetting(Setting setting) async {
    _settingHelper.updateSetting(setting);
  }
}
