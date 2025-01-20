import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/theme_notifier.dart';
import 'package:matrimony_flutter_app/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'Dashboard_Screen.dart';
// Create this file for theme management

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeNotifier.getThemeMode,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const Dashboard_Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
