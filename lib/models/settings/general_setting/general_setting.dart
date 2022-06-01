part of setting;

class GeneralSetting extends Setting {
  GeneralSetting({
    bool? startUpLaunch,
    bool? checkUpdate,
    bool? invert,
    bool? hideRunnder,
    bool? hideLabel,
  })  : hideLabel = hideLabel ?? false,
        invert = invert ?? false,
        hideRunnder = hideRunnder ?? false,
        startUpLaunch = startUpLaunch ?? false,
        checkUpdate = checkUpdate ?? true,
        super(SettingType.general.index);

  // Runner
  bool invert;
  bool hideRunnder;
  bool hideLabel;
  // Startup
  bool startUpLaunch;
  bool checkUpdate;
  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "invert": invert,
      "hideRunnder": hideRunnder,
      "hideLabel": hideLabel,
      "startUpLaunch": startUpLaunch,
      "checkUpdate": checkUpdate,
    };
  }

  factory GeneralSetting.fromMap(dynamic map) {
    final _map = Map<String, dynamic>.from(map);
    return GeneralSetting(
      invert: _map['invert'],
      hideRunnder: _map['hideRunnder'],
      hideLabel: _map['hideLabel'],
      startUpLaunch: _map["startUpLaunch"],
      checkUpdate: _map["checkUpdate"],
    );
  }

  @override
  GeneralSetting copyWith({
    bool? invert,
    bool? hideRunnder,
    bool? hideLabel,
    bool? startUpLaunch,
    bool? checkUpdate,
  }) {
    return GeneralSetting(
      invert: invert ?? this.invert,
      hideRunnder: hideRunnder ?? this.hideRunnder,
      hideLabel: hideLabel ?? this.hideLabel,
      startUpLaunch: startUpLaunch ?? this.startUpLaunch,
      checkUpdate: checkUpdate ?? this.checkUpdate,
    );
  }
}

