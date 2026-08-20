import 'package:flutter/material.dart';
import 'colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: ScaffoldColor.mainGradient),
      child: child,
    );
  }
}
