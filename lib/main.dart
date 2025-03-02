import 'package:flutter/material.dart';
import 'package:matrimony_flutter_app/utils/theme/custom_themes/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'services/navigation_service.dart';
import 'services/shared_prefs.dart';
import 'widgets/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await SharedPrefs.isLoggedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyMatrimonyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyMatrimonyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyMatrimonyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      theme: themeNotifier.getTheme(),
      darkTheme: themeNotifier.getDarkTheme(),
      themeMode: themeNotifier.currentThemeMode,
      home: isLoggedIn ? const Dashboard() : const MyLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
