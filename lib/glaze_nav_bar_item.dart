import 'package:flutter/material.dart';


class GlazeNavBarItem {
  final Widget child;
  final String? label;
  final TextStyle? labelStyle;

  const GlazeNavBarItem({
    required this.child,
    this.label,
    this.labelStyle,
  });
}
