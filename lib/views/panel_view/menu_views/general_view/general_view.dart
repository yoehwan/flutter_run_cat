part of menu_view;

class GeneralView extends MenuView<GeneralViewModel> {
  GeneralView({Key? key})
      : super(
          key: key,
          viewModel: GeneralViewModel(),
        );

  @override
  Widget contents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckMenuView(
          title: viewModel.runnerTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.runnerItemList,
        ),
        CheckMenuView(
          title: viewModel.startUpTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.startUpItemList,
        ),
      ],
    );
  }
}
