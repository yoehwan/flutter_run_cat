part of menu_view_model;

class VersionViewModel extends MenuViewModel {
  @override
  String get viewID => "VersionViewID";
  final VersionController versionController = VersionController.find();

  String get appVersion => versionController.appVersion;
  String get newVersion => versionController.newVersion;

  @override
  Future init() async {
    await versionController.loading;
    super.init();
  }

  final String updateDesc = "updateDesc";

  void onTapGit() async {
    versionController.visitGit();
  }

  void onTapUpdate() {
    versionController.updateVersion();
  }
  
  @override
  Setting get loadSetting => throw UnimplementedError();

  @override
  Future updateSettingOld(SettingItem item)async {
  }

  @override
  Future updateSetting(Setting item) {
    // TODO: implement updateSetting
    throw UnimplementedError();
  }
}
