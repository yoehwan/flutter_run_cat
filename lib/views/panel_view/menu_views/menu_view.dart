library menu_view;

import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_run_cat/controllers/panel_controller/panel_controller.dart';
import 'package:flutter_run_cat/theme.dart';
import 'package:flutter_run_cat/widgets/radio_menu/radio_menu_widget.dart';
import 'package:get/get.dart';
import 'menu_view_model.dart';
import 'package:reorderables/reorderables.dart';

part 'general_view/general_view.dart';
part 'system_info_view/system_info_view.dart';
part 'version_view/version_view.dart';
part 'registration_view/registration_view.dart';

abstract class MenuView extends StatefulWidget {
  const MenuView({super.key});
}

abstract class MenuViewState<T extends MenuView, K extends MenuViewModel>
    extends State<T> with AutomaticKeepAliveClientMixin {
  MenuViewState(this.viewModel);
  final K viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Widget body();
  Widget loadingView() {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<PanelController>(
      id: viewModel.viewID,
      builder: (_) {
        if (viewModel.isLoading) return loadingView();
        return body();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

abstract class MenuViewOld<T extends MenuViewModel> extends StatelessWidget {
  const MenuViewOld({
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
    return GetBuilder<PanelController>(
      id: viewModel.viewID,
      initState: (_) {
        viewModel.init();
      },
      dispose: (_) {
        viewModel.dispose();
      },
      builder: (_) {
        if (viewModel.isLoading) return loadingView();
        return contents();
      },
    );
  }
}
