import 'package:flutter/material.dart';

class TIconTheme {
  TIconTheme._(); // To avoid creating instances

  /// Light Theme
  static final IconThemeData lightIconTheme = IconThemeData(
    color: Colors.black,
    size: 24,
    opacity: 0.8,
  );

  /// Dark Theme
  static final IconThemeData darkIconTheme = IconThemeData(
    color: Colors.white,
    size: 24,
    opacity: 0.8,
  );
}
