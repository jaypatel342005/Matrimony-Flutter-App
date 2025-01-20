import 'package:flutter/material.dart';

class TDialogTheme {
  TDialogTheme._(); // To avoid creating instances

  /// Light Theme
  static final DialogTheme lightDialogTheme = DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 10,
    actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  );

  /// Dark Theme
  static final DialogTheme darkDialogTheme = DialogTheme(
    backgroundColor: Colors.black,
    titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 10,
    actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  );
}
