import 'package:flutter_run_cat/databases/local_box.dart';
import 'package:flutter_run_cat/enums/setting_type.dart';
import 'package:flutter_run_cat/models/runner/runner.dart';
import 'package:flutter_run_cat/models/settings/setting.dart';
import 'package:flutter_run_cat/repos/setting_repo/setting_repo.dart';
import 'package:flutter_run_cat/use_cases/use_case.dart';

class SettingUseCase extends UseCase<SettingRepo> {
  SettingUseCase(SettingRepo repo) : super(repo);

  void addSettingListener(BoxCallback listener) {
    repo.addSettingListener(listener);
  }

  void removeSettingListener(BoxCallback listener) {
    repo.removeSettingListener(listener);
  }

  GeneralSetting loadGeneralSetting() {
    final _res = repo.loadSetting(SettingType.general.index);
    if (_res == null) return GeneralSetting();
    return GeneralSetting.fromMap(_res);
  }

  SystemSetting loadSystemSetting() {
    final _res = repo.loadSetting(SettingType.systemInfo.index);
    if (_res == null) return SystemSetting();
    return SystemSetting.fromMap(_res);
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
    return _res.map((e) => Runner.fromMap(e)).toList();
  }

  Future updateRunner(Runner runner) async {
    await repo.saveImageList(runner.name, runner.itemList);
    await repo.updateRunner(runner.index, runner.toMap());
  }

  Future removeRunner(Runner runner) async {
    await repo.removeRunner(runner.index, runner.name);
  }
}
