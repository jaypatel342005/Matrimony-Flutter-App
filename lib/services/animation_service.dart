import 'package:flutter/material.dart';

class AnimationService {
  static PageRouteBuilder<T> buildPageRoute<T>({
    required Widget page,
    RouteTransitionType type = RouteTransitionType.fade,
    Duration? duration,
    Curve? curve,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration ?? const Duration(milliseconds: 300),
      reverseTransitionDuration: duration ?? const Duration(milliseconds: 300),
      maintainState: true,
      opaque: false,
      barrierDismissible: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: curve ?? Curves.easeInOut,
          reverseCurve: curve ?? Curves.easeInOut,
        );

        switch (type) {
          case RouteTransitionType.fade:
            return FadeTransition(
              opacity: curved,
              child: child,
            );
          
          case RouteTransitionType.scale:
            return ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(curved),
              child: FadeTransition(
                opacity: curved,
                child: child,
              ),
            );
            
          case RouteTransitionType.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(curved),
              child: FadeTransition(
                opacity: curved,
                child: child,
              ),
            );
            
          case RouteTransitionType.slideRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: FadeTransition(
                opacity: curved,
                child: child,
              ),
            );

          case RouteTransitionType.slideLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: FadeTransition(
                opacity: curved,
                child: child,
              ),
            );

          case RouteTransitionType.rotation:
            return RotationTransition(
              turns: Tween<double>(begin: 0.1, end: 0.0).animate(curved),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(curved),
                child: FadeTransition(
                  opacity: curved,
                  child: child,
                ),
              ),
            );
        }
      },
    );
  }

  static Widget wrapWithAnimation({
    required Widget child,
    required AnimationController controller,
    RouteTransitionType type = RouteTransitionType.fade,
  }) {
    final curved = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    switch (type) {
      case RouteTransitionType.fade:
        return FadeTransition(
          opacity: curved,
          child: child,
        );
      
      case RouteTransitionType.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(curved),
          child: child,
        );
        
      default:
        return child;
    }
  }
}

enum RouteTransitionType {
  fade,
  scale,
  slideUp,
  slideRight,
  slideLeft,
  rotation,
} 