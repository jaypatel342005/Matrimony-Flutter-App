import 'package:flutter/material.dart';

class TFloatingActionButtonTheme {
  TFloatingActionButtonTheme._(); // To avoid creating instances

  /// Light Theme
  static final FloatingActionButtonThemeData lightFloatingActionButtonTheme =
  FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: const CircleBorder(),
    highlightElevation: 10,
    extendedTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  /// Dark Theme
  static final FloatingActionButtonThemeData darkFloatingActionButtonTheme =
  FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: const CircleBorder(),
    highlightElevation: 10,
    extendedTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
}
