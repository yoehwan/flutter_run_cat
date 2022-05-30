part of menu_view;

class SystemInfoView extends MenuView<SystemInfoViewModel> {
  SystemInfoView({Key? key})
      : super(
          key: key,
          viewModel: SystemInfoViewModel(),
        );

  @override
  Widget contents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckMenuView(
          title: viewModel.cpuTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.cpuItemList,
        ),
        CheckMenuView(
          title: viewModel.memTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.memItemList,
        ),
        CheckMenuView(
          title: viewModel.batteryTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.batteryItemList,
        ),
        CheckMenuView(
          title: viewModel.diskTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.disItemList,
        ),
      ],
    );
  }
}
