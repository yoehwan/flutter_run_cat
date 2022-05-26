part of menu_view;

class RegistrationView extends MenuView<RegistrationViewModel> {
  RegistrationView({Key? key})
      : super(
          key: key,
          viewModel: RegistrationViewModel(),
        );

  Widget _runnerItemListView() {
    Widget _itemHeadView() {
      Widget _item() {
        final headItem = viewModel.runnerHeadItem;
        if (headItem.isEmpty) {
          return const Center(child: Text("No Image"));
        }
        return Image.file(File(headItem));
      }

      return Row(
        children: [
          SizedBox.square(
            dimension: 80,
            child: _item(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: viewModel.onTapStart,
                  child: const Icon(Icons.play_arrow),
                ),
                GestureDetector(
                  onTap: viewModel.onTapPause,
                  child: const Icon(Icons.pause),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget _itemListView() {
      final itemList = viewModel.itemList;
      Widget _image(int index, double size) {
        ///TODO: Fix badge HitTestBoundary
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
        final isHeadItem = index == viewModel.itemIndex;
        final _style = TextStyle(color: (isHeadItem) ? lightBlue : null);
        return Badge(
          toAnimate: false,
          elevation: 1,
          badgeColor: Colors.transparent,
          padding: EdgeInsets.zero,
          badgeContent: _badge(),
          child: Column(
            children: [
              SizedBox.square(
                dimension: size,
                child: Image.file(File(itemPath)),
              ),
              Text(itemPath.split("/").last, style: _style),
            ],
          ),
        );
      }

      Widget _addIconButton(double size) {
        return SizedBox.square(
          dimension: size,
          child: IconButton(
            onPressed: viewModel.addRunderImage,
            icon: const Icon(Icons.add),
          ),
        );
      }

      return LayoutBuilder(builder: (_, constraitns) {
        final _width = constraitns.maxWidth;
        final _height = constraitns.maxHeight;
        final _minSide = min(_width / 6, _height);
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: lightGrey),
          ),
          child: SizedBox(
            width: _width,
            height: _height,
            child: ReorderableWrap(
              padding: const EdgeInsets.all(16),
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
              const Text("Runner Images"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _itemHeadView(),
              ),
              Expanded(child: _itemListView()),
            ],
          ),
        );
      },
    );
  }

  Widget _runnerListView() {
    Widget runnerItem(int index) {
      final item = viewModel.runnerList[index];
      return GetBuilder<SettingController>(
        key: ValueKey(index),
        id: "Runner${item.index}",
        builder: (_) {
          return ListTile(
            onTap: () {
              viewModel.onTapRunner(index);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            leading: const Icon(Icons.reorder),
            title: Text(item.name),
            trailing: GestureDetector(
              onTap: () {
                viewModel.removeRunner(index);
              },
              child: const Icon(Icons.delete),
            ),
          );
        },
      );
    }

    return GetBuilder<SettingController>(
      id: viewModel.runnerListViewID,
      builder: (_) {
        final _list = viewModel.runnerTitleList;

        return DecoratedBox(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            border: Border.all(color: lightGrey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Column(
              children: [
                const Text("Runner List"),
                Expanded(
                  child: ReorderableListView.builder(
                    itemCount: _list.length,
                    buildDefaultDragHandles: false,
                    itemBuilder: (_, index) {
                      return runnerItem(index);
                    },
                    onReorder: viewModel.reorderRunnerList,
                  ),
                ),
                GestureDetector(
                  onTap: viewModel.addRunner,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _runnerNameField() {
    return Row(
      children: [
        const Text("Runner Name :  "),
        Expanded(
          child: TextField(
            controller: viewModel.nameController,
            decoration: const InputDecoration(
              hintText: "Input Runner Name",
            ),
          ),
        ),
      ],
    );
  }

  Widget _saveButton() {
    return ElevatedButton(
      onPressed: viewModel.onTapSave,
      child: const Text("Save"),
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
        const SizedBox(width: 16),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              _runnerNameField(),
              _runnerItemListView(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _saveButton(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
