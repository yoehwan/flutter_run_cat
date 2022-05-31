part of menu_view;

class GeneralView extends MenuView {
  const GeneralView({super.key});

  @override
  State<StatefulWidget> createState() {
    return GeneralViewState();
  }
}

class GeneralViewState extends MenuViewState<GeneralView, GeneralViewModel> {
  GeneralViewState() : super(GeneralViewModel());

  @override
  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioMenuWidget(
          title: viewModel.runnerTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.runnerItemList,
        ),
        RadioMenuWidget(
          title: viewModel.startUpTitle,
          titleWidth: viewModel.maxTitleWidth,
          itemList: viewModel.startUpItemList,
        ),
      ],
    );
  }
}
