part of menu_view;

class CheckMenuItem {
  CheckMenuItem({
    required this.check,
    required this.desc,
    required this.onTap,
  });
  final bool check;
  final String desc;
  final VoidCallback onTap;
}

class CheckMenuView extends StatelessWidget {
  final String title;
  final double titleWidth;
  final List<CheckMenuItem> itemList;
  const CheckMenuView({
    Key? key,
    required this.title,
    required this.titleWidth,
    required this.itemList,
  }) : super(key: key);

  Widget _itemList() {
    Widget _item(CheckMenuItem item) {
      return Flexible(
        child: Row(
          children: [
            Checkbox(
              value: item.check,
              onChanged: (value) {
                item.onTap();
              },
            ),
            Expanded(child: Text(item.desc))
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: itemList.map(_item).toList(),
    );
  }

  Widget _title() {
    return SizedBox(
      width: titleWidth + 8,
      child: Text(
        title + " :",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _title(),
              ),
              Expanded(child: _itemList()),
            ],
          ),
        ),
      ),
    );
  }
}
