import 'dart:async';

import 'package:flutter_run_cat/databases/local_box.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/repos/setting_repo/setting_impl.dart';
import 'package:flutter_run_cat/use_cases/setting_use_case/setting_use_case.dart';

class SettingHelper {
  static final SettingHelper _settingHelper = SettingHelper._internal();

  factory SettingHelper() {
    return _settingHelper;
  }

  SettingHelper._internal();

  final SettingUseCase _useCase = SettingUseCase(SettingImpl());

  Setting? loadSetting(int typeIndex) {
    return _useCase.loadSetting(typeIndex);
  }

  final Completer _completer = Completer();
  bool _init = false;
  Future init() async {
    if (!_init) {
      _init = true;
      await _useCase.init();
      _completer.complete();
    }
    await _completer.future;
  }

  Future<bool> updateSetting(Setting setting) {
    return _useCase.updateSetting(setting);
  }

  void addSettingListener(BoxCallback listener) {
    _useCase.addSettingListener(listener);
  }

  void removeSettingListener(BoxCallback listener) {
    _useCase.removeSettingListener(listener);
  }

  void updateStartUpLaunch(bool value) {
    _useCase.updateStartUpLaunch(value);
  }

}
