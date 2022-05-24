class Runner {
  Runner({
    int? index,
    required this.name,
    required this.itemList,
  }) : index = index ?? genIndex();

  final int index;
  final String name;
  final List<String> itemList;

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
    final _map = Map<String, dynamic>.from(map);
    return Runner(
      index: _map["index"],
      name: _map["name"],
      itemList: List<String>.from(_map["itemList"]),
    );
  }
}
