import 'dart:io';

const double windowMinWidth = 600;
const double windowMinHeight = 500;

const String autoStartDeskTop = '''[Desktop Entry]
Type=Application
Exec=flutter_run_cat &
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=flutter_run_cat
comment[en_US]=
comment=
''';

final environment = Platform.environment;
String get _home => environment['HOME'] ?? "";
String get _config => "$_home/.config";
String get _app => "$_config/flutter_run_cat";
String get autoStartPath=>"$_config/autostart";
String get dbPath => "$_app/.db";
String get assetPath => "$_app/assets";
