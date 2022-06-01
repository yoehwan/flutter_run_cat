part of setting;

class SystemSetting extends Setting {
  SystemSetting({
    SystemItem? cpuItem,
    SystemItem? memoryItem,
    SystemItem? batteryItem,
    SystemItem? diskItem,
  })  : cpuItem = cpuItem ?? SystemItem.cpu(),
        memoryItem = memoryItem ?? SystemItem.memory(),
        batteryItem = batteryItem ?? SystemItem.battery(),
        diskItem = diskItem ?? SystemItem.disk(),
        super(SettingType.systemInfo.index);
  SystemItem cpuItem;
  SystemItem memoryItem;
  SystemItem batteryItem;
  SystemItem diskItem;

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "cpuItem": cpuItem.toMap(),
      "memoryItem": memoryItem.toMap(),
      "batteryItem": batteryItem.toMap(),
      "diskItem": diskItem.toMap(),
    };
  }

  factory SystemSetting.fromMap(dynamic map) {
    final Map<String, dynamic> _map = Map<String, dynamic>.from(map);
    return SystemSetting(
      cpuItem: SystemItem.fromMap(_map["cpuItem"]),
      memoryItem: SystemItem.fromMap(_map["memoryItem"]),
      batteryItem: SystemItem.fromMap(_map["batteryItem"]),
      diskItem: SystemItem.fromMap(_map["diskItem"]),
    );
  }

  @override
  SystemSetting copyWith({
    SystemItem? cpuItem,
    SystemItem? memoryItem,
    SystemItem? batteryItem,
    SystemItem? diskItem,
  }) {
    return SystemSetting(
      cpuItem: cpuItem ?? this.cpuItem,
      memoryItem: memoryItem ?? this.memoryItem,
      batteryItem: batteryItem ?? this.batteryItem,
      diskItem: diskItem ?? this.diskItem,
    );
  }
}
