part of menu_view_model;

class RegistrationViewModel extends MenuViewModel {
  @override
  String get viewID => "RegistrationViewID";

  Setting get loadSetting =>
      settingController.loadSetting(SettingType.registration.index) ??
      RegistrationSetting(itemList: []);

  List<String> runnerList = ["1", "2", "3"];

  void reorderRunnerList(int oldIndex, int newIndex) {}

  final String runnerItemViewID = "runnerItemViewID";

  void updateRunnerItemView() {
    settingController.update([runnerItemViewID]);
  }

  List<String> imageList = [];

  void reorderRunnerImage(int oldIndex, int newIndex) {}

  void addRunderImage() async {
    final _res = await FilePicker.platform.pickFiles(
      dialogTitle: "Select Runner",
      allowedExtensions: ["png"],
      type: FileType.image,
      allowMultiple: true,
    );
    if (_res == null) return;
    imageList.addAll(_res.files.map((e) => e.path!));
    updateRunnerItemView();
  }

  @override
  Future updateSetting(SettingItem item) async {}

  void onTapDelete(int index) {
    print(index);
    imageList.removeAt(index);
    updateRunnerItemView();
  }
}
