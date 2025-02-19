import 'package:flutter/material.dart';

class TSwitchTheme {
  TSwitchTheme._(); // To avoid creating instances

  /// Light Theme
  static final SwitchThemeData lightSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.blue),
    trackColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.3)),
    splashRadius: 20.0,
  );

  /// Dark Theme
  static final SwitchThemeData darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.all(Colors.blueAccent),
    trackColor: WidgetStateProperty.all(Colors.blueAccent.withOpacity(0.3)),
    splashRadius: 20.0,
  );
}
