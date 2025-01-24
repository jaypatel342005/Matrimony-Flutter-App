import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'MyApp.dart';
// Make sure to import your MyApp widget here

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child:  MyApp(),
    ),
  );
}