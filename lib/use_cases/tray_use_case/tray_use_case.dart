import 'package:flutter_app_indicator/flutter_app_indicator.dart';
import 'package:flutter_run_cat/repos/tray_repo/tray_repo.dart';
import 'package:flutter_run_cat/use_cases/use_case.dart';

class TrayUseCase extends UseCase<TrayRepo> {
  TrayUseCase(super.repo);

  @override
  Future init({
    String? title,
    String? iconPath,
    String? label,
  }) async {
    await repo.init(
      title: title,
      iconPath: iconPath,
      label: label,
    );
  }

  Future updateLabel(String label) async {
    await repo.updateLabel(label);
  }

  Future updateIcon(String iconPath) async {
    await repo.updateIcon(iconPath);
  }

  Future setMenu(List<MenuItemBase> list) async {
    await repo.setMenu(list);
  }
}
