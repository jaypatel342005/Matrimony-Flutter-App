import 'package:flutter/material.dart';
import 'animation_service.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final List<Route<dynamic>> _routeHistory = [];

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<T?> navigateTo<T>(Widget page, {bool replace = false}) async {
    final route = MaterialPageRoute<T>(builder: (context) => page);
    if (replace) {
      return await navigatorKey.currentState?.pushReplacement(route);
    }
    return await navigatorKey.currentState?.push(route);
  }

  static void goBack<T>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop(result);
    }
  }

  static Future<T?> navigateWithAnimation<T>({
    required Widget page,
    bool replace = false,
    bool clearStack = false,
    RouteTransitionType type = RouteTransitionType.fade,
    Duration? duration,
    Curve? curve,
  }) async {
    try {
      final route = AnimationService.buildPageRoute<T>(
        page: page,
        type: type,
        duration: duration,
        curve: curve,
      );

      if (clearStack) {
        return await navigator?.pushAndRemoveUntil(route, (route) => false);
      }

      if (replace) {
        return await navigator?.pushReplacement(route);
      }

      _routeHistory.add(route);
      return await navigator?.push(route);
    } catch (e) {
      debugPrint('Navigation error: $e');
      return null;
    }
  }

  static Future<void> navigateWithFade(Widget page,
      {bool replace = false}) async {
    if (replace) {
      await Navigator.pushReplacement(
        navigatorKey.currentContext!,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      await Navigator.push(
        navigatorKey.currentContext!,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  static Future<T?> navigateWithScale<T>(
    Widget page, {
    bool replace = false,
    Duration? duration,
  }) {
    return navigateWithAnimation<T>(
      page: page,
      replace: replace,
      type: RouteTransitionType.scale,
      duration: duration,
    );
  }

  static Future<T?> navigateWithSlideUp<T>(
    Widget page, {
    bool replace = false,
    Duration? duration,
  }) {
    return navigateWithAnimation<T>(
      page: page,
      replace: replace,
      type: RouteTransitionType.slideUp,
      duration: duration,
    );
  }

  static void popUntil(bool Function(Route<dynamic>) predicate) {
    navigator?.popUntil(predicate);
  }

  static void popToFirst() {
    navigator?.popUntil((route) => route.isFirst);
  }

  static bool canPop() {
    return navigator?.canPop() ?? false;
  }

  static void pop<T>([T? result]) {
    if (canPop()) {
      navigator?.pop(result);
      if (_routeHistory.isNotEmpty) {
        _routeHistory.removeLast();
      }
    }
  }

  static void popToRoot() {
    while (canPop()) {
      pop();
    }
    _routeHistory.clear();
  }

  static Route? get currentRoute {
    return _routeHistory.isNotEmpty ? _routeHistory.last : null;
  }

  static int get routeCount => _routeHistory.length;
}
