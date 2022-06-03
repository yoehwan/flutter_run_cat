part of menu_view_model;

class SystemInfoViewModel extends CheckMenuViewModel<SystemSetting> {
  @override
  String get viewID => "SystemViewID";

  @override
  SystemSetting get loadSetting {
    final _res = controller.loadSetting(SettingType.systemInfo.index);
    if (_res == null) return SystemSetting();
    return _res as SystemSetting;
  }

  @override
  List<String> get titleList => [
        cpuTitle,
        memTitle,
        batteryTitle,
      ];
  final String _showTrayText = "Show in Tray";

  /// CPU
  final String cpuTitle = "CPU Usage";

  List<RadioMenuItem> get cpuItemList {
    final enable = setting.enableCpu;
    return [
      RadioMenuItem(
        check: enable,
        desc: _showTrayText,
        onTap: () {
          updateSetting(setting.copyWith(enableCpu: !enable));
        },
      )
    ];
  }

  /// Memory
  final String memTitle = "Memory Performance";

  List<RadioMenuItem> get memItemList {
    final enable = setting.enableMemory;
    return [
      RadioMenuItem(
        check: enable,
        desc: _showTrayText,
        onTap: () {
          updateSetting(setting.copyWith(enableMemory: !enable));
        },
      )
    ];
  }

  /// Battery
  final String batteryTitle = "Battery State";

  List<RadioMenuItem> get batteryItemList {
    final enable = setting.enableBattery;
    return [
      RadioMenuItem(
        check: enable,
        desc: _showTrayText,
        onTap: () {
          updateSetting(setting.copyWith(enableBattery: !enable));
        },
      )
    ];
  }

  final diskTitle = "Disk Usage";

  List<RadioMenuItem> get diskItemList {
    final enable = setting.enableDisk;
    return [
      RadioMenuItem(
        check: enable,
        desc: _showTrayText,
        onTap: () {
          updateSetting(setting.copyWith(enableDisk: !enable));
        },
      )
    ];
  }

  @override
  Future updateSettingOld(SettingItem item) async {
    // SystemSetting _res = setting;
    // SystemItem _item = item as SystemItem;
    // switch (item.type) {
    //   case SettingItemType.runner:
    //   case SettingItemType.startUp:
    //     return;
    //   case SettingItemType.cpu:
    //     _res = _res.copyWith(cpuItem: _item);
    //     break;
    //   case SettingItemType.memory:
    //     _res = _res.copyWith(memoryItem: _item);
    //     break;
    //   case SettingItemType.battery:
    //     _res = _res.copyWith(batteryItem: _item);
    //     break;
    //   case SettingItemType.disk:
    //     _res = _res.copyWith(diskItem: _item);
    //     break;
    //   case SettingItemType.network:
    //     break;
    //   case SettingItemType.registration:
    //     // TODO: Handle this case.
    //     break;
    // }
    //
    // await controller.updateSetting(_res);
    // refreshSetting();
    // updateView();
  }

  @override
  Future updateSetting(SystemSetting item) async {
    await controller.updateSetting(item);
    refreshSetting();
    updateView();
  }
}
