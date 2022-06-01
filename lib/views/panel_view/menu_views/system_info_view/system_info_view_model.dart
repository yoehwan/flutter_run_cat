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
  final String _activateText = "Activate";
  final String _menuText = "Show in the menu bar";

  /// CPU
  final String cpuTitle = "CPU Usage";

  List<RadioMenuItem> get cpuItemList {
    final _item = setting.cpuItem;
    return [
      RadioMenuItem(
        check: _item.showMenu,
        desc: _menuText,
        onTap: () {
          updateSettingOld(_item.copyWith(showMenu: !_item.showMenu));
        },
      )
    ];
  }

  /// Memory
  final String memTitle = "Memory Performance";

  List<RadioMenuItem> get memItemList {
    final _item = setting.memoryItem;
    return [
      RadioMenuItem(
        check: _item.showTray,
        desc: _activateText,
        onTap: () {
          updateSettingOld(_item.copyWith(showTray: !_item.showTray));
        },
      ),
      RadioMenuItem(
        check: _item.showMenu,
        desc: _menuText,
        onTap: () {
          updateSettingOld(_item.copyWith(showMenu: !_item.showMenu));
        },
      ),
    ];
  }

  /// Battery
  final String batteryTitle = "Battery State";

  List<RadioMenuItem> get batteryItemList {
    final _item = setting.batteryItem;
    return [
      RadioMenuItem(
        check: _item.showTray,
        desc: _activateText,
        onTap: () {
          updateSettingOld(_item.copyWith(showTray: !_item.showTray));
        },
      ),
      RadioMenuItem(
        check: _item.showMenu,
        desc: _menuText,
        onTap: () {
          updateSettingOld(_item.copyWith(showMenu: !_item.showMenu));
        },
      ),
    ];
  }

  final diskTitle = "Disk Usage";

  List<RadioMenuItem> get disItemList {
    final _item = setting.diskItem;
    return [
      RadioMenuItem(
        check: _item.showTray,
        desc: _activateText,
        onTap: () {
          updateSettingOld(_item.copyWith(showTray: !_item.showTray));
        },
      ),
      RadioMenuItem(
        check: _item.showMenu,
        desc: _menuText,
        onTap: () {
          updateSettingOld(_item.copyWith(showMenu: !_item.showMenu));
        },
      ),
    ];
  }

  @override
  Future updateSettingOld(SettingItem item) async {
    SystemSetting _res = setting;
    SystemItem _item = item as SystemItem;
    switch (item.type) {
      case SettingItemType.runner:
      case SettingItemType.startUp:
        return;
      case SettingItemType.cpu:
        _res = _res.copyWith(cpuItem: _item);
        break;
      case SettingItemType.memory:
        _res = _res.copyWith(memoryItem: _item);
        break;
      case SettingItemType.battery:
        _res = _res.copyWith(batteryItem: _item);
        break;
      case SettingItemType.disk:
        _res = _res.copyWith(diskItem: _item);
        break;
      case SettingItemType.network:
        break;
      case SettingItemType.registration:
        // TODO: Handle this case.
        break;
    }

    await controller.updateSetting(_res);
    refreshSetting();
    updateView();
  }

  @override
  Future updateSetting(SystemSetting item)async {
    await controller.updateSetting(item);
    refreshSetting();
    updateView();
  }
}
