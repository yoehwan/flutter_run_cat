import 'package:flutter_app_indicator/flutter_app_indicator.dart';
import 'package:flutter_run_cat/repos/tray_repo/tray_repo.dart';

class TrayImpl extends TrayRepo {
  final FlutterAppIndicator indicator = FlutterAppIndicator();

  @override
  Future init({
    String? title,
    String? iconPath,
    String? label,
  }) async {
    await indicator.init(
      title: "RunCat",
      iconPath: iconPath ?? "assets/cat/",
      label: "",
    );
  }

  @override
  Future updateLabel(String label) async {
    await indicator.setLabel(label);
  }

  @override
  Future updateIcon(String iconPath) async {
    await indicator.setIcon(iconPath);
  }

  @override
  Future setMenu(List<MenuItemBase> menuList) async {
    await indicator.setMenu(menuList);
  }
}
