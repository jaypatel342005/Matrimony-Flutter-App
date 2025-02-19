import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get currentThemeMode => _themeMode;

  ThemeData getTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      // Add other light theme configurations
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      // Add other dark theme configurations
    );
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
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
