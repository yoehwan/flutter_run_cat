part of menu_view_model;

class RegistrationViewModel extends MenuViewModel {
  @override
  String get viewID => "RegistrationViewID";
  final String runnerListViewID = "runnerListViewID";

  void updateRunnerListView() {
    settingController.update([runnerListViewID]);
  }

  Setting get loadSetting =>
      settingController.loadSetting(SettingType.registration.index) ??
      RegistrationSetting(itemList: []);

  final TextEditingController nameController = TextEditingController();

  final List<Runner> runnerList = [];
  List<String> get runnerTitleList => runnerList.map((e) => e.name).toList();
  @override
  void ready() {
    loadRunnerList();
    super.ready();
  }

  void loadRunnerList() {
    if (runnerList.isNotEmpty) {
      runnerList.clear();
    }
    final _res = settingController.loadRunnerList();
    runnerList.addAll(_res);
  }

  int? _currnetRunnerIndex;
  Runner? get currentRunner {
    if (_currnetRunnerIndex == null) return null;
    return runnerList[_currnetRunnerIndex!];
  }

  void onTapRunner(int index) {
    _currnetRunnerIndex = index;
    nameController.text = currentRunner!.name;
    updateView();
  }

  void removeRunner(int index) async {
    final _runner = runnerList[index];
    await settingController.removeRunner(_runner);
    runnerList.removeAt(index);
    updateRunnerListView();
  }

  void addRunner() {
    final _runner = Runner(name: "New Runner");
    runnerList.add(_runner);
    settingController.updateRunner(_runner);
    updateView();
  }

  void reorderRunnerList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = runnerList.removeAt(oldIndex);
    runnerList.insert(newIndex, item);
    updateRunnerListView();
  }

  final String runnerItemViewID = "runnerItemViewID";

  void updateRunnerItemView() {
    settingController.update([runnerItemViewID]);
  }

  final List<String> itemList = [];
  final Ticker _itemTicker = Ticker();
  int itemIndex = 0;
  Future _onTick(int index) async {
    final _list = itemList;
    final _len = _list.length;
    if (_len <= 1) return;
    itemIndex = index % _len;
    updateRunnerItemView();
  }

  String get runnerHeadItem {
    if (itemList.isEmpty) return "";
    return itemList[itemIndex];
  }

  void onTapStart() {
    onTapPause();
    _itemTicker.start(
      duration: Duration(milliseconds: 200),
      onTick: _onTick,
    );
  }

  void onTapPause() {
    if (_itemTicker.isActivate) _itemTicker.dispose();
    itemIndex = 0;
  }

  void reorderRunnerImage(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final String item = itemList.removeAt(oldIndex);
    itemList.insert(newIndex, item);
    updateRunnerItemView();
  }

  void addRunderImage() async {
    final _res = await FilePicker.platform.pickFiles(
      dialogTitle: "Select Runner",
      allowedExtensions: ["png"],
      type: FileType.image,
      allowMultiple: true,
    );
    if (_res == null) return;
    itemList.addAll(_res.files.map((e) => e.path!));
    updateRunnerItemView();
  }

  @override
  Future updateSetting(SettingItem item) async {}

  void onTapDelete(int index) {
    itemList.removeAt(index);
    updateRunnerItemView();
  }

  void onTapSave() async {
    final _name = nameController.text;
    final _runner = currentRunner ?? Runner(name: "", itemList: []);
    _runner.name = _name;
    _runner.itemList = itemList;
    await settingController.updateRunner(_runner);
    loadRunnerList();
    updateView();
  }
}
