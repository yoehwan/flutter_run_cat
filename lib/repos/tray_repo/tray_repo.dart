import 'package:flutter_app_indicator/flutter_app_indicator.dart';
import 'package:flutter_run_cat/repos/repo.dart';

abstract class TrayRepo extends Repo {
  @override
  Future init({String? title, String? iconPath, String? label});

  Future updateLabel(String label);

  Future updateIcon(String iconPath);

  Future setMenu(List<MenuItemBase> menuList);
}
