library menu_view_model;

import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_run_cat/controllers/setting_controller/setting_controller.dart';
import 'package:flutter_run_cat/controllers/version_controller/version_controller.dart';
import 'package:flutter_run_cat/enums/setting_item_type.dart';
import 'package:flutter_run_cat/enums/setting_type.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/models/settings/setting_item.dart';
import 'package:flutter_run_cat/utils/ticker.dart';
import 'menu_view.dart';

part 'general_view/general_view_model.dart';
part 'system_info_view/system_info_view_model.dart';
part 'version_view/version_view_model.dart';
part 'registration_view/registration_view_model.dart';

abstract class MenuViewModel {
  MenuViewModel() {
    init();
  }
  final SettingController settingController = SettingController.find();

  String get viewID;

  bool _loadig = true;
  bool get isLoading => _loadig;

  /// if has no dependency, write here.
  Future init() async {
    await settingController.loading;
    ready();
  }

  /// if dependency on 'setting', write here.
  /// wait for ready [SettingController].
  void ready() {
    _loadig = false;
    updateView();
  }

  void updateView() {
    settingController.update([viewID]);
  }

  Future updateSetting(SettingItem item);
}

abstract class CheckMenuViewModel<T extends Setting> extends MenuViewModel {
  late T setting;

  T get loadSetting;

  void refreshSetting() {
    setting = loadSetting;
  }

  @override
  void ready() {
    refreshSetting();
    maxTitleWidth = computeMaxTitleWidth(titleList);
    super.ready();
  }

  List<String> get titleList;
  double maxTitleWidth = 0;
  double computeMaxTitleWidth(List<String> titleList) {
    double res = 0;

    final TextPainter _tp = TextPainter(textDirection: TextDirection.ltr);

    for (final title in titleList) {
      _tp.text = TextSpan(text: title);
      _tp.layout();
      final _tmpWitdh = _tp.width;
      res = max(res, _tmpWitdh);
    }

    return res;
  }
}
