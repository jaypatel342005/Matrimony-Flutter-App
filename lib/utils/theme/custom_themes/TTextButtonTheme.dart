import 'package:flutter/material.dart';

class TTextButtonTheme {
  TTextButtonTheme._(); // To avoid creating instances

  /// Light Theme
  static final TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      // primary: Colors.blue,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      side: const BorderSide(color: Colors.blue),
    ),
  );

  /// Dark Theme
  static final TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      // primary: Colors.white,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      side: const BorderSide(color: Colors.blueAccent),
    ),
  );
}
