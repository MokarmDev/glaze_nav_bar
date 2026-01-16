import 'package:flutter/material.dart';


class GlazeNavBarItem {
  final Widget child;
  final String? label;
  final TextStyle? labelStyle;
  final int? badgeCount;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final bool showBadge;

  const GlazeNavBarItem({
    required this.child,
    this.label,
    this.labelStyle,
    this.badgeCount,
    this.badgeColor,
    this.badgeTextColor,
    this.showBadge = false,
  });
}
