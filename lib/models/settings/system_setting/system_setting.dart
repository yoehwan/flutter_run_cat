part of setting;

class SystemSetting extends Setting {
  SystemSetting({
    bool? enableCpu,
    bool? enableMemory,
    bool? enableBattery,
    bool? enableDisk,
  })  : enableCpu = enableCpu ?? true,
        enableMemory = enableMemory ?? false,
        enableBattery = enableBattery ?? false,
        enableDisk = enableDisk ?? false,
        super(SettingType.systemInfo.index);
  final bool enableCpu;
  final bool enableMemory;
  final bool enableBattery;
  final bool enableDisk;

  @override
  SystemSetting copyWith({
    bool? enableCpu,
    bool? enableMemory,
    bool? enableBattery,
    bool? enableDisk,
  }) {
    return SystemSetting(
      enableCpu: enableCpu ?? this.enableCpu,
      enableMemory: enableMemory ?? this.enableMemory,
      enableBattery: enableBattery ?? this.enableBattery,
      enableDisk: enableDisk ?? this.enableDisk,
    );
  }

  factory SystemSetting.fromMap(dynamic map) {
    final _map = Map<String, dynamic>.from(map);
    return SystemSetting(
      enableCpu: _map["enableCpu"],
      enableMemory: _map["enableMemory"],
      enableBattery: _map["enableBattery"],
      enableDisk: _map["enableDisk"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "enableCpu": enableCpu,
      "enableMemory": enableMemory,
      "enableBattery": enableBattery,
      "enableDisk": enableDisk,
    };
  }
}

// class SystemSetting extends Setting {
//   SystemSetting({
//     SystemItem? cpuItem,
//     SystemItem? memoryItem,
//     SystemItem? batteryItem,
//     SystemItem? diskItem,
//   })  : cpuItem = cpuItem ?? SystemItem.cpu(),
//         memoryItem = memoryItem ?? SystemItem.memory(),
//         batteryItem = batteryItem ?? SystemItem.battery(),
//         diskItem = diskItem ?? SystemItem.disk(),
//         super(SettingType.systemInfo.index);
//   SystemItem cpuItem;
//   SystemItem memoryItem;
//   SystemItem batteryItem;
//   SystemItem diskItem;
//
//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       "typeIndex": typeIndex,
//       "cpuItem": cpuItem.toMap(),
//       "memoryItem": memoryItem.toMap(),
//       "batteryItem": batteryItem.toMap(),
//       "diskItem": diskItem.toMap(),
//     };
//   }
//
//   factory SystemSetting.fromMap(dynamic map) {
//     final Map<String, dynamic> _map = Map<String, dynamic>.from(map);
//     return SystemSetting(
//       cpuItem: SystemItem.fromMap(_map["cpuItem"]),
//       memoryItem: SystemItem.fromMap(_map["memoryItem"]),
//       batteryItem: SystemItem.fromMap(_map["batteryItem"]),
//       diskItem: SystemItem.fromMap(_map["diskItem"]),
//     );
//   }
//
//   @override
//   SystemSetting copyWith({
//     SystemItem? cpuItem,
//     SystemItem? memoryItem,
//     SystemItem? batteryItem,
//     SystemItem? diskItem,
//   }) {
//     return SystemSetting(
//       cpuItem: cpuItem ?? this.cpuItem,
//       memoryItem: memoryItem ?? this.memoryItem,
//       batteryItem: batteryItem ?? this.batteryItem,
//       diskItem: diskItem ?? this.diskItem,
//     );
//   }
// }
