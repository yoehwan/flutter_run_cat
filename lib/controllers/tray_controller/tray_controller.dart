import 'package:flutter_app_indicator/flutter_app_indicator.dart';
import 'package:flutter_run_cat/controllers/controllers.dart';
import 'package:flutter_run_cat/enums/setting_type.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/utils/setting_helper.dart';
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
  final FlutterAppIndicator _indicator = FlutterAppIndicator();
  final TrayView _trayView = TrayView('assets/cat/');
  final SettingHelper _settingHelper = SettingHelper();
  final SystemHelper _systemHelper = SystemHelper();
  final WindowHelper _windowHelper = WindowHelper();
  SystemSetting get loadSystemSetting {
    final _res = _settingHelper.loadSetting(SettingType.systemInfo.index);
    if (_res == null) return SystemSetting();
    return _res as SystemSetting;
  }

  GeneralSetting get loadGeneralSetting {
    final _res = _settingHelper.loadSetting(SettingType.general.index);
    if (_res == null) return GeneralSetting();
    return _res as GeneralSetting;
  }

  int get cpuUsage => _systemHelper.cpuUsage();
  System get loadSystem => _systemHelper.system;

  @override
  void onInit() async {
    await _settingHelper.init();
    await _systemHelper.init();
    super.onInit();
  }

  @override
  Future onReady() async {
    super.onReady();
    await _initTray();
    initTicker();
    _settingHelper.addSettingListener(settingListener);
  }

  @override
  void dispose() {
    _settingHelper.removeSettingListener(settingListener);
    super.dispose();
  }

  Future _initTray() async {
    await _indicator.init(
      title: "runCat",
      iconPath: _trayView.nextIcon(),
      label: _label(),
    );
    await _indicator.setMenu([
      MenuItem("Preference", _windowHelper.showWindow),
      MenuDivider(),
      MenuItem("Exit", _windowHelper.closeWindow),
    ]);
  }

  String _label() {
    final _generalSetting = loadGeneralSetting;
    if (_generalSetting.runnerItem.hideLabel) {
      return "";
    }
    final _system = loadSystem;
    final _systemSetting = loadSystemSetting;
    final _battery = _system.battery;
    return _trayView.label(
      cpu: cpuUsage,
      memory: _system.memory.value(_systemSetting.memoryItem.showTray),
      battteryStatus: _battery.statusIndex,
      battery: _battery.value(_systemSetting.batteryItem.showTray),
      disk: _system.disk.value(_systemSetting.diskItem.showTray),
    );
  }

  /// Ticker
  final Ticker _iconTicker = Ticker();
  Duration _iconDuration() {
    try {
      final _generalSetting = loadGeneralSetting;
      final _isInvert = _generalSetting.runnerItem.invert;
      final _duration =
          _isInvert ? _defaultRevIconDuration : _defaultIconDuration;
      final _gapDuration = Duration(milliseconds: cpuUsage);
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
    await _indicator.setIcon(_trayView.nextIcon());
  }

  Future onSystemTick(int index) async {
    await _indicator.setLabel(_label());
    _iconTicker.update(duration: _iconDuration());
  }

  void settingListener(dynamic typeIndex, dynamic value) {
    final type = SettingType.values[typeIndex];
    switch (type) {
      case SettingType.general:
        _iconTicker.update(duration: _iconDuration());
        _indicator.setLabel(_label());
        break;
      case SettingType.systemInfo:
        _indicator.setLabel(_label());
        break;
      case SettingType.registration:
        break;
    }
  }
}
