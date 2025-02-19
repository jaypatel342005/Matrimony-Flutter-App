import 'package:flutter/material.dart';
import 'dart:async';

class LoadingOverlayService {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;
  static Timer? _dismissTimer;

  static void show(
    BuildContext context, {
    String? message,
    Widget? customIndicator,
    Duration? autoDismissAfter,
    bool barrierDismissible = false,
  }) {
    if (_isVisible) return;
    _isVisible = true;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: barrierDismissible ? hide : null,
              child: Container(
                color: isDarkMode 
                    ? Colors.black.withOpacity(0.7)
                    : Colors.black54,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customIndicator ?? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDarkMode ? Colors.white : theme.primaryColor,
                    ),
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    if (autoDismissAfter != null) {
      _dismissTimer?.cancel();
      _dismissTimer = Timer(autoDismissAfter, hide);
    }
  }

  static void hide() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isVisible = false;
  }

  static bool get isVisible => _isVisible;
} 