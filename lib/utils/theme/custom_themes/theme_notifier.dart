import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get getThemeMode => _themeMode;

  void toggleTheme() {
    if (_themeMode == ThemeMode.light ||
        (_themeMode == ThemeMode.system && WidgetsBinding.instance.window.platformBrightness == Brightness.light)) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void resetToSystemTheme() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }

  // This method is used to apply the system theme priority
  void updateBasedOnSystemTheme() {
    if (_themeMode == ThemeMode.system) {
      notifyListeners();
    }
  }
}
