class Runner {
  Runner({
    int? index,
    required this.name,
    List<String>? itemList,
  })  : itemList = itemList ?? [],
        index = index ?? genIndex();

  final int index;
  String name;
  List<String> itemList;

  static int genIndex() {
    return DateTime.now().millisecondsSinceEpoch & 0xFFFFFF;
  }

  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "name": name,
      "itemList": itemList,
    };
  }

  factory Runner.fromMap(dynamic map) {
    final Map<String, dynamic> _map = Map<String, dynamic>.from(map);
    return Runner(
      index: _map["index"],
      name: _map["name"],
      itemList: List<String>.from(_map["itemList"]),
    );
  }
}
