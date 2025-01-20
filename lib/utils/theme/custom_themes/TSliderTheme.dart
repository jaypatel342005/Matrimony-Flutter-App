import 'package:flutter/material.dart';

class TSliderTheme {
  TSliderTheme._(); // To avoid creating instances

  /// Light Theme
  static final SliderThemeData lightSliderTheme = SliderThemeData(
    activeTrackColor: Colors.blue,
    inactiveTrackColor: Colors.blue.withOpacity(0.3),
    thumbColor: Colors.blue,
    overlayColor: Colors.blue.withOpacity(0.1),
    valueIndicatorColor: Colors.blue,
    valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    showValueIndicator: ShowValueIndicator.always,
    trackHeight: 4.0,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
  );

  /// Dark Theme
  static final SliderThemeData darkSliderTheme = SliderThemeData(
    activeTrackColor: Colors.blueAccent,
    inactiveTrackColor: Colors.blueAccent.withOpacity(0.3),
    thumbColor: Colors.blueAccent,
    overlayColor: Colors.blueAccent.withOpacity(0.1),
    valueIndicatorColor: Colors.blueAccent,
    valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    showValueIndicator: ShowValueIndicator.always,
    trackHeight: 4.0,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
  );
}
