import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar({required String text, Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: duration,
    ));
  }
}