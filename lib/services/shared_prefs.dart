import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserId = 'userId';

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  static Future<void> setLoggedIn(bool value, {int? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, value);
    if (userId != null) {
      await prefs.setInt(keyUserId, userId);
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
