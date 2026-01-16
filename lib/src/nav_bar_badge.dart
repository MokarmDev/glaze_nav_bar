import 'package:flutter/material.dart';

class NavBarBadge extends StatelessWidget {
  final int? count;
  final Color backgroundColor;
  final Color textColor;
  final bool showDot;
  final Widget child;

  const NavBarBadge({
    super.key,
    this.count,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.showDot = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowBadge = showDot || (count != null && count! > 0);

    if (!shouldShowBadge) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -6,
          top: -4,
          child: AnimatedScale(
            scale: shouldShowBadge ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: showDot ? _buildDot() : _buildCountBadge(),
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildCountBadge() {
    final displayText = count! > 99 ? '99+' : count.toString();
    final isSmall = count! < 10;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 4 : 6,
        vertical: 2,
      ),
      constraints: BoxConstraints(
        minWidth: isSmall ? 16 : 20,
        minHeight: 16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          displayText,
          style: TextStyle(
            color: textColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ),
    );
  }
}
