import 'dart:io';

import 'package:flutter/material.dart';

class NavBarItemWidget extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final String? label;
  final TextStyle? labelStyle;

  // Badge properties
  final int? badgeCount;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Color? activeBadgeColor;
  final Color? activeBadgeTextColor;
  final bool showBadge;

  const NavBarItemWidget({
    super.key,
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    this.label,
    this.labelStyle,
    this.badgeCount,
    this.badgeColor,
    this.badgeTextColor,
    this.activeBadgeColor,
    this.activeBadgeTextColor,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(index),
        child: _buildItem(),
      ),
    );
  }

  Widget _buildItem() {
    if (label == null) {
      return Column(
        children: [
          Expanded(child: _buildIcon()),
          SizedBox(height: Platform.isIOS ? 20.0 : 0),
        ],
      );
    }
    return Column(
      children: [
        Expanded(flex: 2, child: _buildIcon()),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(label ?? '', style: labelStyle),
          ),
        ),
        SizedBox(height: Platform.isIOS ? 20.0 : 10.0),
      ],
    );
  }

  Widget _buildIcon() {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;

    // Determine if this item is active (selected)
    final isActive = difference < 0.01;

    // Build icon with badge
    Widget iconWithBadge = child;

    // Only show badge if count > 0 or showBadge is true
    if ((badgeCount != null && badgeCount! > 0) || showBadge) {
      final bgColor = isActive
          ? (activeBadgeColor ?? badgeColor ?? Colors.red)
          : (badgeColor ?? Colors.red);
      final txtColor = isActive
          ? (activeBadgeTextColor ?? badgeTextColor ?? Colors.white)
          : (badgeTextColor ?? Colors.white);

      if (showBadge && (badgeCount == null || badgeCount == 0)) {
        // Show dot badge
        iconWithBadge = Badge(
          alignment: Alignment.topRight,
          backgroundColor: bgColor,
          smallSize: 8,
          child: child,
        );
      } else {
        // Show count badge
        iconWithBadge = Badge.count(
          count: badgeCount!,
          alignment: Alignment.topRight,
          textColor: txtColor,
          backgroundColor: bgColor,
          child: child,
        );
      }
    }

    return Transform.translate(
      offset: Offset(
        0,
        difference < 1.0 / length ? verticalAlignment * 40 : 0,
      ),
      child: Opacity(
        opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
        child: Center(child: iconWithBadge),
      ),
    );
  }
}
