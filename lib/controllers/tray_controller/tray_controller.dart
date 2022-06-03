import 'package:flutter_app_indicator/flutter_app_indicator.dart';
import 'package:flutter_run_cat/controllers/controllers.dart';
import 'package:flutter_run_cat/enums/setting_type.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/repos/setting_repo/setting_impl.dart';
import 'package:flutter_run_cat/repos/tray_repo/tray_impl.dart';
import 'package:flutter_run_cat/use_cases/setting_use_case/setting_use_case.dart';
import 'package:flutter_run_cat/use_cases/tray_use_case/tray_use_case.dart';
import 'package:flutter_run_cat/utils/system_helper.dart';
import 'package:flutter_run_cat/utils/ticker.dart';
import 'package:flutter_run_cat/utils/window_helper.dart';
import 'package:flutter_run_cat/views/tray_view/tray_view.dart';

import '../../models/system/system.dart';

const _defaultIconDuration = Duration(milliseconds: 200);
const _defaultRevIconDuration = Duration(milliseconds: 100);

/// TODO: appIndicator make that be able to receive raw data of Icon, no path.
/// It can be save cpu, but can be need more memory?
class TrayController extends Controller {
  final SettingUseCase settingUseCase = SettingUseCase(SettingImpl());

  SystemSetting get loadSystemSetting => settingUseCase.loadSystemSetting();

  GeneralSetting get loadGeneralSetting => settingUseCase.loadGeneralSetting();

  void initSettingListener() {
    settingUseCase.addSettingListener(settingListener);
  }

  void settingListener(dynamic typeIndex, dynamic value) {
    final type = SettingType.values[typeIndex];
    switch (type) {
      case SettingType.general:
        _iconTicker.update(duration: _iconDuration());
        trayUseCase.updateLabel(_label());
        break;
      case SettingType.systemInfo:
        trayUseCase.updateLabel(_label());
        break;
      case SettingType.registration:
        break;
    }
  }

  void disposeSettingListener() {
    settingUseCase.removeSettingListener(settingListener);
  }

  final TrayUseCase trayUseCase = TrayUseCase(TrayImpl());

  final TrayView _trayView = TrayView('assets/cat/');
  final SystemHelper _systemHelper = SystemHelper();
  final WindowHelper _windowHelper = WindowHelper();

  int cpuUsage(bool enable) {
    return _systemHelper.cpuUsage();
  }

  System get loadSystem => _systemHelper.system;

  @override
  void onInit() async {
    await settingUseCase.init();
    initSettingListener();
    await _systemHelper.init();
    super.onInit();
  }

  @override
  Future onReady() async {
    super.onReady();
    await _initTray();
    initTicker();
  }

  @override
  void dispose() {
    disposeSettingListener();
    super.dispose();
  }

  Future _initTray() async {
    await trayUseCase.init(
      title: "runCat",
      iconPath: _trayView.nextIcon(),
      label: _label(),
    );
    await trayUseCase.setMenu([
      MenuItem("Preference", _windowHelper.showWindow),
      MenuDivider(),
      MenuItem("Exit", _windowHelper.closeWindow),
    ]);
  }

  String _label() {
    final _generalSetting = loadGeneralSetting;
    if (_generalSetting.hideLabel) {
      return "";
    }
    final _system = loadSystem;
    final _systemSetting = loadSystemSetting;
    final _battery = _system.battery;
    return _trayView.label(
      cpu: cpuUsage(_systemSetting.enableCpu),
      memory: _system.memory.value(_systemSetting.enableMemory),
      battteryStatus: _battery.statusIndex,
      battery: _battery.value(_systemSetting.enableBattery),
      disk: _system.disk.value(_systemSetting.enableDisk),
    );
  }

  /// Ticker
  final Ticker _iconTicker = Ticker();
  Duration _iconDuration() {
    try {
      final _generalSetting = loadGeneralSetting;
      final _isInvert = _generalSetting.invert;
      final _duration =
          _isInvert ? _defaultRevIconDuration : _defaultIconDuration;
      final _gapDuration = Duration(milliseconds: cpuUsage(true));
      if (_isInvert) {
        return _duration + _gapDuration;
      }
      return _duration - _gapDuration;
    } catch (e) {
      // print(e);
      return _defaultIconDuration;
    }
  }

  final Ticker _systemTicker = Ticker();
  void initTicker() {
    _iconTicker.start(duration: _defaultIconDuration, onTick: onIconTick);
    _systemTicker.start(
        duration: const Duration(seconds: 1), onTick: onSystemTick);
  }

  Future onIconTick(_) async {
    await trayUseCase.updateIcon(_trayView.nextIcon());
  }

  Future onSystemTick(int index) async {
    await trayUseCase.updateLabel(_label());
    _iconTicker.update(duration: _iconDuration());
  }
}
