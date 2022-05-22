part of menu_view;

class RegistrationView extends MenuView<RegistrationViewModel> {
  RegistrationView({Key? key})
      : super(
          key: key,
          viewModel: RegistrationViewModel(),
        );

  Widget _runnerItemListView() {
    Widget _itemHeadView() {
      Widget _item(String? item) {
        if (item == null) {
          return Text("@@@");
        }
        return Image.file(File(item!));
      }

      return Row(
        children: [
          ColoredBox(
            color: Colors.red,
            child: SizedBox.square(
              dimension: 80,
              child: _item(null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow),
              ],
            ),
          ),
        ],
      );
    }

    Widget _itemListView() {
      final itemList = viewModel.imageList;
      Widget _image(int index, double size) {
        Widget _badge() {
          return GestureDetector(
            onTap: () {
              viewModel.onTapDelete(index);
            },
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: lightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16),
            ),
          );
        }

        final itemPath = itemList[index];
        return Badge(
          toAnimate: false,
          elevation: 1,
          badgeColor: Colors.transparent,
          padding: EdgeInsets.zero,
          badgeContent: _badge(),
          child: SizedBox.square(
            dimension: size,
            child: Image.file(File(itemPath)),
          ),
        );
      }

      Widget _addIconButton(double size) {
        return SizedBox.square(
          dimension: size,
          child: IconButton(
            onPressed: viewModel.addRunderImage,
            icon: Icon(Icons.add),
          ),
        );
      }

      return LayoutBuilder(builder: (_, constraitns) {
        final _width = constraitns.maxWidth;
        final _height = constraitns.maxHeight;
        final _minSide = min(_width / 5, _height);
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: lightGrey),
          ),
          child: SizedBox(
            width: _width,
            height: _height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ReorderableWrap(
                runSpacing: 8,
                spacing: 8,
                ignorePrimaryScrollController: true,
                footer: _addIconButton(_minSide),
                children: [
                  for (int index = 0; index < itemList.length; index++)
                    _image(index, _minSide),
                ],
                onReorder: viewModel.reorderRunnerImage,
              ),
            ),
          ),
        );
      });
    }

    return GetBuilder<SettingController>(
      id: viewModel.runnerItemViewID,
      builder: (_) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Runner Images"),
              ),
              _itemHeadView(),
              Expanded(child: _itemListView()),
            ],
          ),
        );
      },
    );
  }

  Widget _runnerListView() {
    return DecoratedBox(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(5),
        border: Border.all(color: lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Text("Runner List"),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: viewModel.runnerList.length,
                itemBuilder: (_, index) {
                  final item = viewModel.runnerList[index];
                  return SizedBox(
                    key: ValueKey(item),
                    child: Text(item),
                  );
                },
                onReorder: viewModel.reorderRunnerList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _runnerNameField() {
    return Row(
      children: [
        Text("Runner Name :"),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Input Runner Name",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget contents() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _runnerListView(),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              _runnerNameField(),
              _runnerItemListView(),
            ],
          ),
        ),
      ],
    );
  }
}
