part of menu_view;

class VersionView extends MenuView<VersionViewModel> {
  VersionView({Key? key})
      : super(
          key: key,
          viewModel: VersionViewModel(),
        );

  @override
  Widget contents() {
    return Column(
      children: [
        Text("Run Cat", style: Get.textTheme.headline4),
        Text("Version : ${viewModel.appVersion}"),
        ElevatedButton(
          onPressed: viewModel.onTapGit,
          child: Text("Github"),
        ),
      ],
    );
  }
}
