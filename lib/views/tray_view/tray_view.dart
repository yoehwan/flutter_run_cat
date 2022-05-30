class TrayView {
  TrayView(this.iconDir);

  String iconDir;

  int _count = 0;

  String nextIcon() {
    _count++;
    final _index = _count % 5;
    return iconDir + '$_index.png';
  }

  void updateIconDir(String newIconDir) {
    iconDir = newIconDir;
    _count = 0;
  }

  String label({
    required int cpu,
    required int? memory,
    required int battteryStatus,
    required int? battery,
    required int? disk,
  }) {
    String _res = " CPU: $cpu%";
    if (memory != null) {
      _res += " Memory: $memory%";
    }
    if (battery != null) {
      _res += _batteryLabel(battteryStatus, battery);
    }
    if (disk != null) {
      _res += " Disk: $disk%";
    }
    return _res;
  }

  String _batteryLabel(int status, int value) {
    // final _type = BattteryStatus.values[status];
    String _res = " Battery:";
    // _res += "$status";
    // switch (_type) {
    // case BattteryStatus.disCharge:
    // break;
    // case BattteryStatus.charge:
    // break;
    // case BattteryStatus.notCharge:
    // break;
    // }
    return _res + " $value%";
  }
}
