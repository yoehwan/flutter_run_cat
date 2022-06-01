library setting;

import 'package:flutter_run_cat/enums/setting_item_type.dart';
import 'package:flutter_run_cat/enums/setting_type.dart';
import 'package:flutter_run_cat/models/settings/setting_item.dart';

part 'general_setting/general_setting.dart';
part 'general_setting/general_setting_item.dart';
part 'system_setting/system_setting.dart';
part 'system_setting/system_setting_item.dart';
part 'registration_setting/registration_setting.dart';
part 'registration_setting/registration_setting_item.dart';

abstract class Setting {
  Setting(this.typeIndex);
  final int typeIndex;
  SettingType get type => SettingType.values[typeIndex];

  static Setting fromMap(dynamic map) {
    final _typeIndex = map["typeIndex"];
    assert(_typeIndex != null);
    final _type = SettingType.values[_typeIndex as int];
    switch (_type) {
      case SettingType.general:
        return GeneralSetting.fromMap(map);
      case SettingType.systemInfo:
        return SystemSetting.fromMap(map);
      case SettingType.registration:
        return RegistrationSetting.fromMap(map);
    }
  }

  Map<String, dynamic> toMap();

  Setting copyWith();
}
