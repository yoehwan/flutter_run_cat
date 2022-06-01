part of setting;

class RegistrationSetting extends Setting {
  RegistrationSetting({required this.itemList})
      : super(SettingType.registration.index);
  List<RegistrationSettingItem> itemList;
  @override
  RegistrationSetting copyWith({List<RegistrationSettingItem>? itemList}) {
    return RegistrationSetting(
      itemList: itemList ?? this.itemList,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "itemList": itemList.map((e) => e.toMap()).toList(),
    };
  }

  factory RegistrationSetting.fromMap(dynamic map) {
    final Map<String, dynamic> _map = Map<String, dynamic>.from(map);
    return RegistrationSetting(
      itemList: (_map["itemList"] as List)
          .map((e) => RegistrationSettingItem.fromMap(e))
          .toList(),
    );
  }
}
