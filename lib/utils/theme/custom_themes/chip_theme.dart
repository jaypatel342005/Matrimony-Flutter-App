import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._(); // Private constructor to prevent instantiation

  /// Light Chip Theme
  static final ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
    backgroundColor: Colors.white,
    secondarySelectedColor: Colors.blueAccent,
    shadowColor: Colors.black.withOpacity(0.1),
    surfaceTintColor: Colors.transparent,
    showCheckmark: true,
  );

  /// Dark Chip Theme
  static final ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
    backgroundColor: Colors.black,
    secondarySelectedColor: Colors.lightBlue,
    shadowColor: Colors.white.withOpacity(0.1),
    surfaceTintColor: Colors.transparent,
    showCheckmark: true,
  );
}
