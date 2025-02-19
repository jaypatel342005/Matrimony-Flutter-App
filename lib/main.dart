import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:matrimony_flutter_app/services/navigation_service.dart';
import 'MyApp.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: const MyMatrimonyApp(),
    ),
  );
}

class MyMatrimonyApp extends StatelessWidget {
  const MyMatrimonyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      theme: themeNotifier.getTheme(),
      darkTheme: themeNotifier.getDarkTheme(),
      themeMode: themeNotifier.currentThemeMode,
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}