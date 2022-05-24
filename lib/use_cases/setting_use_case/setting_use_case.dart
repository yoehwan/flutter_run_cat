import 'package:flutter_run_cat/models/runner/runner.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/repos/setting_repo/setting_repo.dart';
import 'package:flutter_run_cat/use_cases/use_case.dart';

class SettingUseCase extends UseCase<SettingRepo> {
  SettingUseCase(SettingRepo repo) : super(repo);

  void addSettingListener(Function(int typeIndex) listener) {
    repo.addSettingListener(listener);
  }

  void removeSettingListener(Function(int typeIndex) listener) {
    repo.removeSettingListener(listener);
  }

  Setting? loadSetting(int typeIndex) {
    final _res = repo.loadSetting(typeIndex);
    if (_res == null) return null;
    return Setting.fromMap(_res);
  }

  Future<bool> updateSetting(Setting setting) {
    return repo.updateSetting(setting.typeIndex, setting.toMap());
  }

  void updateStartUpLaunch(bool value) {
    repo.updateStartUpLaunch(value);
  }

  List<Runner> loadRunnerList() {
    final _res = repo.loadRunnerList();
    return _res.map((e) => Runner(e)).toList();
  }
}
