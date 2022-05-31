part of menu_view;

class SystemInfoView extends MenuViewOld<SystemInfoViewModel> {
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
        RadioMenuWidget(
          title: viewModel.cpuTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.cpuItemList,
        ),
        RadioMenuWidget(
          title: viewModel.memTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.memItemList,
        ),
        RadioMenuWidget(
          title: viewModel.batteryTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.batteryItemList,
        ),
        RadioMenuWidget(
          title: viewModel.diskTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.disItemList,
        ),
      ],
    );
  }
}
