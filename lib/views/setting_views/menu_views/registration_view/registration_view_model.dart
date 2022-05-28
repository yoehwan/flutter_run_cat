part of menu_view_model;

class RegistrationViewModel extends MenuViewModel {
  @override
  String get viewID => "RegistrationViewID";
  final String runnerListViewID = "runnerListViewID";
  void updateRunnerViewID(int runnerIndex) {
    settingController.update(["Runner$runnerIndex"]);
  }

  void updateRunnerListView() {
    settingController.update([runnerListViewID]);
  }

  Setting get loadSetting =>
      settingController.loadSetting(SettingType.registration.index) ??
      RegistrationSetting(itemList: []);

  final TextEditingController nameController = TextEditingController();

  void initNameListener() {
    nameController.addListener(nameListener);
  }

  void nameListener() {
    if (_selectedRunnerIndex == null) return;
    final newName = nameController.text;
    final runner = runnerList[_selectedRunnerIndex!].copyWith(name: newName);
    updateRunner(runner);
    updateRunnerListView();
  }

  void disposeNameListener() {
    nameController.removeListener(nameListener);
  }

  List<String> get runnerTitleList => runnerList.map((e) => e.name).toList();

  List<Runner> get runnerList => settingController.loadRunnerList();
  

  int _indexWhereRunner(int runnerIndex) {
    return runnerList.indexWhere((e) => e.index == runnerIndex);
  }

  Future updateRunner(Runner runner) async {
    final index = _indexWhereRunner(runner.index);
    if (index == -1) {
      runnerList.add(runner);
    } else {
      runnerList[index] = runner;
    }
    await settingController.updateRunner(runner);
  }

  @override
  void ready() {
    loadRunnerList();
    initNameListener();
    super.ready();
  }

  @override
  void dispose() {
    disposeNameListener();
  }

  void loadRunnerList() {
    if (runnerList.isNotEmpty) {
      runnerList.clear();
    }
    final _res = settingController.loadRunnerList();
    runnerList.addAll(_res);
  }

  int? _selectedRunnerIndex;

  bool isSelectedRunner(int index) {
    return _selectedRunnerIndex == index;
  }

  void _selectRunner(int index) {
    _selectedRunnerIndex = index;
    final runner = runnerList[index];
    nameController.text = runner.name;
    loadItemList(runner);
  }

  void onTapRunner(int index) {
    _selectRunner(index);
    updateView();
  }

  void removeRunner(int index) async {
    final _runner = runnerList[index];
    await settingController.removeRunner(_runner);
    runnerList.removeAt(index);
    updateRunnerListView();
  }

  void addRunner() async {
    int index = 1;
    String name = "New Runner";
    while (runnerTitleList.contains(name + "$index")) {
      index++;
    }
    final _runner = Runner(name: name + "$index");
    await updateRunner(_runner);
    _selectRunner(runnerList.length - 1);
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

  void loadItemList(Runner runner) {
    itemList.clear();
    itemList.addAll(runner.itemList);
  }

  int itemIndex = 0;
  final Ticker _itemTicker = Ticker();
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
    if (_itemTicker.isActivate) return;
    _itemTicker.start(
      duration: const Duration(milliseconds: 200),
      onTick: _onTick,
    );
  }

  void onTapPause() {
    if (_itemTicker.isActivate) _itemTicker.dispose();
    itemIndex = 0;
  }

  Future _updateItemList(List<String> itemList) async {
    final runner =
        runnerList[_selectedRunnerIndex!].copyWith(itemList: itemList);
    await updateRunner(runner);
  }

  void reorderRunnerImage(int oldIndex, int newIndex) async {
    final String item = itemList.removeAt(oldIndex);
    itemList.insert(newIndex, item);
    await _updateItemList(itemList);
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
    await _updateItemList(itemList);
    updateRunnerItemView();
  }

  @override
  Future updateSetting(SettingItem item) async {}

  void onTapRemove(int index) {
    itemList.removeAt(index);
    updateRunnerItemView();
  }

  void onTapSave() async {
    // final _name = nameController.text;
    // final _runner = currentRunner ?? Runner(name: "", itemList: []);
    //
    // _runner.name = _name;
    // _runner.itemList = itemList;
    // await settingController.updateRunner(_runner);
    // loadRunnerList();
    // updateView();
  }
}
