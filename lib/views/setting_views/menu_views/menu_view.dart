library menu_view;

import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_run_cat/controllers/setting_controller/setting_controller.dart';
import 'package:flutter_run_cat/theme.dart';
import 'package:get/get.dart';
import 'menu_view_model.dart';
import 'package:reorderables/reorderables.dart';

part 'check_menu_view.dart';

part 'general_view/general_view.dart';
part 'system_info_view/system_info_view.dart';
part 'version_view/version_view.dart';
part 'registration_view/registration_view.dart';

abstract class MenuView<T extends MenuViewModel> extends StatelessWidget {
  const MenuView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final T viewModel;
  Widget contents();

  Widget loadingView() {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      id: viewModel.viewID,
      initState: (_) {
        viewModel.init();
      },
      builder: (_) {
        if (viewModel.isLoading) return loadingView();
        return contents();
      },
    );
  }
}
