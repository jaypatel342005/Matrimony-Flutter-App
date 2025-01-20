import 'package:flutter/material.dart';

class TListTileTheme {
  TListTileTheme._(); // To avoid creating instances

  /// Light Theme
  static final ListTileThemeData lightListTileTheme = ListTileThemeData(
    iconColor: Colors.black,
    textColor: Colors.black,
    selectedColor: Colors.blue.withOpacity(0.1),
    tileColor: Colors.transparent,
    horizontalTitleGap: 16.0,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  /// Dark Theme
  static final ListTileThemeData darkListTileTheme = ListTileThemeData(
    iconColor: Colors.white,
    textColor: Colors.white,
    selectedColor: Colors.blueAccent.withOpacity(0.1),
    tileColor: Colors.transparent,
    horizontalTitleGap: 16.0,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
