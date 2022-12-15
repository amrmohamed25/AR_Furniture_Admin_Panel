import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    required Key key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1100) {
      return mobile;
    } else
      return desktop;
  }
}
