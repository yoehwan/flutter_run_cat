import 'package:flutter_run_cat/databases/local_box.dart';
import 'package:flutter_run_cat/repos/repo.dart';

abstract class SettingRepo extends Repo {
  void addSettingListener(BoxCallback listener);

  void removeSettingListener(BoxCallback listener);

  dynamic loadSetting(int typeIndex);

  Future<bool> updateSetting(int typeIndex, Map<String, dynamic> data);

  void updateStartUpLaunch(bool value);

  /// Runner
  List<dynamic> loadRunnerList();

  Future updateRunner(String name, List<String> itemList);
}
