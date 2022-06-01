part of menu_view_model;

class GeneralViewModel extends CheckMenuViewModel<GeneralSetting> {
  @override
  String get viewID => "GeneralViewID";

  @override
  GeneralSetting get loadSetting {
    final _res = controller.loadSetting(SettingType.general.index);
    if (_res == null) return GeneralSetting();
    return _res as GeneralSetting;
  }

  @override
  List<String> get titleList => [runnerTitle, startUpTitle];

  final String runnerTitle = "Runner";

  List<RadioMenuItem> get runnerItemList {
    final _item = setting;
    return [
      RadioMenuItem(
        check: _item.invert,
        desc: "Invert (The lighter CPU loads, the faster th speed)",
        onTap: () {
          updateSetting(_item.copyWith(invert: !_item.invert));
        },
      ),

      /// TODO: need fix AppIndicator Icon Bug!
      // RadioMenuItem(
      //   check: _item.hideRunnder,
      //   desc: "Hide Runnder",
      //   onTap: () {
      //     updateSetting(_item.copyWith(hideRunnder: !_item.hideRunnder));
      //   },
      // ),
      RadioMenuItem(
        check: _item.hideLabel,
        desc: "Hide Label",
        onTap: () {
          updateSetting(_item.copyWith(hideLabel: !_item.hideLabel));
        },
      ),
    ];
  }

  final String startUpTitle = "Startup";

  List<RadioMenuItem> get startUpItemList {
    final _item = setting;
    return [
      RadioMenuItem(
        check: _item.startUpLaunch,
        desc: "Launch RunCat at Login",
        onTap: () {
          final _value = !_item.startUpLaunch;
          controller.updateStartUpLaunch(_value);
          updateSetting(_item.copyWith(startUpLaunch: _value));
        },
      ),

      /// TODO: make [VersionController].
      // RadioMenuItem(
      //   check: _item.checkUpdate,
      //   desc: "Check for Update when Startup",
      //   onTap: () {
      //     updateSetting(_item.copyWith(checkUpdate: !_item.checkUpdate));
      //   },
      // )
    ];
  }

  @override
  Future updateSettingOld(SettingItem item) async {
    // GeneralSetting _res = setting;
    // switch (item.type) {
    //   case SettingItemType.runner:
    //     final _item = item as GeneralRunnerItem;
    //     _res = _res.copyWith(runnerItem: _item);
    //     break;
    //   case SettingItemType.startUp:
    //     final _item = item as GeneralStartUpItem;
    //     _res = _res.copyWith(startUpItem: _item);
    //     break;
    //   case SettingItemType.cpu:
    //   case SettingItemType.memory:
    //   case SettingItemType.battery:
    //   case SettingItemType.disk:
    //   case SettingItemType.network:
    //     return;
    //   case SettingItemType.registration:
    //     break;
    // }
    // await controller.updateSetting(_res);
    // refreshSetting();
    // updateView();
  }

  @override
  Future updateSetting(GeneralSetting item) async {
    await controller.updateSetting(item);
    refreshSetting();
    updateView();
  }
}
