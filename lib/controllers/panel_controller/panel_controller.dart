import 'dart:ui';

import 'package:flutter_run_cat/consts.dart';
import 'package:flutter_run_cat/controllers/controllers.dart';
import 'package:flutter_run_cat/models/runner/runner.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/repos/setting_repo/setting_impl.dart';
import 'package:flutter_run_cat/use_cases/setting_use_case/setting_use_case.dart';
import 'package:flutter_run_cat/utils/window_helper.dart';
import 'package:get/get.dart';

class PanelController extends Controller {
  static PanelController find() => Get.find<PanelController>();

  final WindowHelper _windowHelper = WindowHelper();
  final SettingUseCase settingUsecase = SettingUseCase(SettingImpl());
  @override
  void onInit() async {
    await settingUsecase.init();
    _windowHelper.initWindow(const Size(windowMinWidth, windowMinHeight));
    super.onInit();
  }

  Setting? loadSetting(int typeIndex) {
    return settingUsecase.loadSetting(typeIndex);
  }

  void updateStartUpLaunch(bool value) {
    settingUsecase.updateStartUpLaunch(value);
  }

  List<Runner> loadRunnerList() {
    return settingUsecase.loadRunnerList();
  }

  Future updateRunner(Runner runner) async {
    await settingUsecase.updateRunner(runner);
  }

  Future removeRunner(Runner runner) async {
    await settingUsecase.removeRunner(runner);
  }

  Future updateSetting(Setting setting) async {
    settingUsecase.updateSetting(setting);
  }

  void hideWindow() {
    _windowHelper.hideWindow();
  }
}
