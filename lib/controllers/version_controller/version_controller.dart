import 'package:flutter_run_cat/controllers/controllers.dart';
import 'package:flutter_run_cat/enums/setting_type.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/repos/version_repo/version_impl.dart';
import 'package:flutter_run_cat/use_cases/version_use_case/version_use_case.dart';
import 'package:flutter_run_cat/utils/setting_helper.dart';
import 'package:get/get.dart';

/// It Will be grow up to Version Updater in Future.
class VersionController extends Controller {
  static VersionController find() => Get.find<VersionController>();
  final SettingHelper _settingHelper = SettingHelper();
  final VersionUseCase _useCase = VersionUseCase(VersionImpl());

  @override
  void onInit() async {
    await _settingHelper.init();
    await _useCase.init();
    appVersion = _useCase.appVersion();
    newVersion = _useCase.newVersion();
    super.onInit();
  }

  @override
  Future onReady() async {
    await _init();
    super.onReady();
  }

  String appVersion = "";
  String newVersion = "";
  bool get hasUpdate => appVersion != newVersion;
  Future _init() async {
    final _setting = _settingHelper.loadSetting(SettingType.general.index);
    if (_setting != null) {
      final _generalSetting = _setting as GeneralSetting;
      if (!_generalSetting.checkUpdate) return;
    }
  }

  void visitGit() {
    _useCase.visitGit();
  }

  void updateVersion() {
    _useCase.updateVersion();
  }
}
