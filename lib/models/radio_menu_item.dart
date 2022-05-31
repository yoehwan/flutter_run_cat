import 'package:flutter/widgets.dart';

class RadioMenuItem {
  RadioMenuItem({
    required this.check,
    required this.desc,
    required this.onTap,
  });
  final bool check;
  final String desc;
  final VoidCallback onTap;
}
