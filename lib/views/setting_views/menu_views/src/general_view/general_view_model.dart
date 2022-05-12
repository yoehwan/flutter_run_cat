part of menu_view_model;

class GeneralViewModel extends CheckMenuViewModel<GeneralSetting> {
  @override
  String get viewID => settingController.generalViewID;

  @override
  GeneralSetting get loadSetting {
    final _res = settingController.loadSetting(SettingType.general.index);
    if (_res == null) return GeneralSetting();
    return _res as GeneralSetting;
  }

  @override
  List<String> get titleList => [
        runnerTitle,
        startUpTitle,
      ];

  final String runnerTitle = "Runner";

  List<CheckMenuItem> get runnerItemList {
    return [
      CheckMenuItem(
        check: setting.invert,
        desc: "Invert (The lighter CPU loads, the faster th speed)",
        onTap: () {
          updateSetting((value) {
            value.invert = !value.invert;
          });
        },
      ),
      CheckMenuItem(
        check: setting.hideRunnder,
        desc: "Hide Runnder",
        onTap: () {
          updateSetting((value) {
            value.hideRunnder = !value.hideRunnder;
          });
        },
      ),
      CheckMenuItem(
        check: setting.hideLabel,
        desc: "Hide Label",
        onTap: () {
          updateSetting((value) {
            value.hideLabel = !value.hideLabel;
          });
        },
      ),
    ];
  }

  final String startUpTitle = "Startup";

  List<CheckMenuItem> get startUpItemList {
    return [
      CheckMenuItem(
        check: setting.startUpLaunch,
        desc: "Launch RunCat at Login",
        onTap: () {
          updateSetting((value) {
            value.startUpLaunch = !value.startUpLaunch;
          });
        },
      ),
      CheckMenuItem(
        check: setting.checkUpdate,
        desc: "Check for Update when Startup",
        onTap: () {
          updateSetting((value) {
            value.checkUpdate = !value.checkUpdate;
          });
        },
      )
    ];
  }
}