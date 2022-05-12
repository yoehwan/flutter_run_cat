part of menu_view_model;

class VersionViewModel extends MenuViewModel {
  @override
  String get viewID => settingController.versionViewID;
  final VersionController versionController = VersionController.find();

  String get appVersion => versionController.appVersion;
  String get newVersion => versionController.newVersion;

  @override
  Future init() async {
    await versionController.loading;
  }

  final String updateDesc = "updateDesc";

  void onTapUpdate() async {
    final _res = await Get.dialog(const UpdateAlertView());
    if (_res == null) return;
    if(_res){
      versionController.updateVersion();
    }
  }
}