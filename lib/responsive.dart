import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    required this.mobile,
    required this.desktop,
  });
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 850) {
      return mobile;
    } else {
      return desktop;
    }
  }
}
