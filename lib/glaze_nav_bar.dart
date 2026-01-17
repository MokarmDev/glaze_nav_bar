import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'glaze_nav_bar_item.dart';
import 'src/nav_bar_item_widget.dart';
import 'src/nav_custom_clipper.dart';

typedef _LetIndexPage = bool Function(int value);

/// A stunning glassmorphic bottom navigation bar with gradient support,
/// smooth animations, and modern design.
///
/// The bar consists of a curved shape with a floating button that
/// moves to the selected item with smooth animations.
///
/// Example usage:
/// ```dart
/// GlazeNavBar(
///   items: [
///     GlazeNavBarItem(child: Icon(Icons.home), label: 'Home'),
///     GlazeNavBarItem(child: Icon(Icons.search), label: 'Search'),
///     GlazeNavBarItem(child: Icon(Icons.settings), label: 'Settings'),
///   ],
///   onTap: (index) => setState(() => _currentIndex = index),
/// )
/// ```
class GlazeNavBar extends StatefulWidget {
  final List<GlazeNavBarItem> items;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Gradient? gradient;
  final Gradient? buttonGradient;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final double? maxWidth;
  final double iconPadding;
  final bool hasLabel;
  final double glassBlur;
  final double glassOpacity;
  final double glassBorderRadius;
  final double glassBorderWidth;
  final Color glassBorderColor;
  final Color buttonBorderColor;
  final double buttonBorderWidth;

  GlazeNavBar({
    Key? key,
    required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.transparent,
    this.onTap,
    this.gradient,
    this.buttonGradient,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.iconPadding = 12.0,
    this.maxWidth,
    this.glassBlur = 20,
    this.glassOpacity = 0.2,
    this.glassBorderRadius = 0,
    this.glassBorderWidth = 1.5,
    this.glassBorderColor = Colors.white,
    this.buttonBorderColor = Colors.white,
    this.buttonBorderWidth = 3.0,
    double? height,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= index && index < items.length),
        assert(maxWidth == null || 0 <= maxWidth),
        height = height ?? (Platform.isAndroid ? 70.0 : 80.0),
        hasLabel = items.any((item) => item.label != null),
        super(key: key);

  @override
  GlazeNavBarState createState() => GlazeNavBarState();
}

class GlazeNavBarState extends State<GlazeNavBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  late int _endingIndex;
  late double _pos;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;
  double _buttonHide = 0;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index].child;
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _endingIndex = widget.index;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value.clamp(0.0, 1.0);
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex].child;
        }
        // Prevent division by zero and NaN values
        final denominator = _startingPos - middle;
        if (denominator.abs() < 0.0001) {
          _buttonHide = 1.0;
        } else {
          _buttonHide =
              (1 - ((middle - _pos) / denominator).abs()).abs().clamp(0.0, 1.0);
        }
      });
    });
  }

  @override
  void didUpdateWidget(GlazeNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(
        newPosition,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    }
    if (!_animationController.isAnimating) {
      _icon = widget.items[_endingIndex].child;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = min(
            constraints.maxWidth,
            widget.maxWidth ?? constraints.maxWidth,
          );
          return Align(
            alignment: textDirection == TextDirection.ltr
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: Container(
              color: widget.backgroundColor,
              width: maxWidth,
              child: ClipRect(
                clipper: NavCustomClipper(
                  deviceHeight: MediaQuery.sizeOf(context).height,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    // Floating button
                    Positioned(
                      bottom: widget.height - 105.0,
                      left: textDirection == TextDirection.rtl
                          ? null
                          : (_pos * maxWidth).clamp(0.0, maxWidth),
                      right: textDirection == TextDirection.rtl
                          ? (_pos * maxWidth).clamp(0.0, maxWidth)
                          : null,
                      width: maxWidth / _length,
                      child: Center(
                        child: Transform.translate(
                          offset: Offset(
                              0,
                              ((_buttonHide.isNaN ? 1.0 : _buttonHide) - 1) *
                                  80),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: widget.buttonGradient,
                              color: widget.buttonGradient == null
                                  ? (widget.buttonBackgroundColor ??
                                      widget.color)
                                  : null,
                              border: Border.all(
                                color: widget.buttonBorderColor,
                                width: widget.buttonBorderWidth,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              type: MaterialType.circle,
                              child: Padding(
                                padding: EdgeInsets.all(widget.iconPadding),
                                child: _buildFloatingIcon(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Glassmorphism Background
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipPath(
                        clipper: _NavBarClipper(
                          startingLoc: _pos,
                          itemsLength: _length,
                          hasLabel: widget.hasLabel,
                          textDirection: Directionality.of(context),
                          height: widget.height,
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: widget.glassBlur,
                            sigmaY: widget.glassBlur,
                          ),
                          child: Container(
                            width: maxWidth,
                            height: widget.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                widget.glassBorderRadius,
                              ),
                              gradient: widget.gradient as LinearGradient? ??
                                  LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      widget.color
                                          .withOpacity(widget.glassOpacity),
                                      widget.color.withOpacity(
                                          widget.glassOpacity * 0.5),
                                    ],
                                    stops: const [0.1, 1],
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Border stroke on top of glassmorphism
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: IgnorePointer(
                        child: CustomPaint(
                          size: Size(maxWidth, widget.height),
                          painter: _NavBarBorderPainter(
                            startingLoc: _pos,
                            itemsLength: _length,
                            hasLabel: widget.hasLabel,
                            textDirection: Directionality.of(context),
                            borderColor: widget.glassBorderColor,
                            borderWidth: widget.glassBorderWidth,
                          ),
                        ),
                      ),
                    ),
                    // Navigation items
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: widget.height,
                        child: Row(
                          children: widget.items.map((item) {
                            return NavBarItemWidget(
                              onTap: _buttonTap,
                              position: _pos,
                              length: _length,
                              index: widget.items.indexOf(item),
                              label: item.label,
                              labelStyle: item.labelStyle,
                              badgeCount: item.badgeCount,
                              badgeColor: item.badgeColor,
                              badgeTextColor: item.badgeTextColor,
                              activeBadgeColor: item.activeBadgeColor,
                              activeBadgeTextColor: item.activeBadgeTextColor,
                              showBadge: item.showBadge,
                              child: item.child,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds the floating button icon with badge if applicable.
  Widget _buildFloatingIcon() {
    final item = widget.items[_endingIndex];

    // If no badge count and showBadge is false, return just the icon
    if ((item.badgeCount == null || item.badgeCount == 0) && !item.showBadge) {
      return _icon;
    }

    // Get active colors (floating button is always the active item)
    final bgColor = item.activeBadgeColor ?? item.badgeColor ?? Colors.red;
    final txtColor =
        item.activeBadgeTextColor ?? item.badgeTextColor ?? Colors.white;

    if (item.showBadge && (item.badgeCount == null || item.badgeCount == 0)) {
      // Show dot badge
      return Badge(
        alignment: Alignment.topRight,
        backgroundColor: bgColor,
        smallSize: 8,
        child: _icon,
      );
    }

    // Show count badge
    return Badge.count(
      count: item.badgeCount!,
      alignment: Alignment.topRight,
      textColor: txtColor,
      backgroundColor: bgColor,
      child: _icon,
    );
  }

  /// Programmatically sets the current page index.
  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index) || _animationController.isAnimating) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(
        newPosition,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    });
  }
}

/// Custom clipper for the navigation bar glass effect.
class _NavBarClipper extends CustomClipper<Path> {
  final double startingLoc;
  final int itemsLength;
  final bool hasLabel;
  final TextDirection textDirection;
  final double height;

  _NavBarClipper({
    required this.startingLoc,
    required this.itemsLength,
    required this.hasLabel,
    required this.textDirection,
    required this.height,
  });

  @override
  Path getClip(Size size) {
    // Guard against invalid size
    if (size.width <= 0 || size.height <= 0) {
      return Path()..addRect(Rect.zero);
    }

    const s = 0.2;
    final span = 1.0 / itemsLength;
    final l = startingLoc + (span - s) / 2;
    // Clamp loc to valid range to prevent geometry errors
    final loc =
        (textDirection == TextDirection.rtl ? 0.8 - l : l).clamp(0.0, 1.0 - s);
    final bottom = hasLabel
        ? (Platform.isAndroid ? 0.55 : 0.45)
        : (Platform.isAndroid ? 0.6 : 0.5);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * (loc - 0.05).clamp(0.0, 1.0), 0)
      ..cubicTo(
        size.width * (loc + s * 0.2).clamp(0.0, 1.0),
        size.height * 0.05,
        size.width * loc.clamp(0.0, 1.0),
        size.height * bottom,
        size.width * (loc + s * 0.5).clamp(0.0, 1.0),
        size.height * bottom,
      )
      ..cubicTo(
        size.width * (loc + s).clamp(0.0, 1.0),
        size.height * bottom,
        size.width * (loc + s * 0.8).clamp(0.0, 1.0),
        size.height * 0.05,
        size.width * (loc + s + 0.05).clamp(0.0, 1.0),
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_NavBarClipper oldClipper) {
    return startingLoc != oldClipper.startingLoc ||
        itemsLength != oldClipper.itemsLength ||
        hasLabel != oldClipper.hasLabel;
  }
}

/// Custom painter for drawing border on the navigation bar.
class _NavBarBorderPainter extends CustomPainter {
  final double startingLoc;
  final int itemsLength;
  final bool hasLabel;
  final TextDirection textDirection;
  final Color borderColor;
  final double borderWidth;

  _NavBarBorderPainter({
    required this.startingLoc,
    required this.itemsLength,
    required this.hasLabel,
    required this.textDirection,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Guard against invalid size
    if (size.width <= 0 || size.height <= 0) return;

    const s = 0.2;
    final span = 1.0 / itemsLength;
    final l = startingLoc + (span - s) / 2;
    // Clamp loc to valid range to prevent geometry errors
    final loc =
        (textDirection == TextDirection.rtl ? 0.8 - l : l).clamp(0.0, 1.0 - s);
    final bottom = hasLabel
        ? (Platform.isAndroid ? 0.55 : 0.45)
        : (Platform.isAndroid ? 0.6 : 0.5);

    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * (loc - 0.05).clamp(0.0, 1.0), 0)
      ..cubicTo(
        size.width * (loc + s * 0.2).clamp(0.0, 1.0),
        size.height * 0.05,
        size.width * loc.clamp(0.0, 1.0),
        size.height * bottom,
        size.width * (loc + s * 0.5).clamp(0.0, 1.0),
        size.height * bottom,
      )
      ..cubicTo(
        size.width * (loc + s).clamp(0.0, 1.0),
        size.height * bottom,
        size.width * (loc + s * 0.8).clamp(0.0, 1.0),
        size.height * 0.05,
        size.width * (loc + s + 0.05).clamp(0.0, 1.0),
        0,
      )
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_NavBarBorderPainter oldDelegate) {
    return startingLoc != oldDelegate.startingLoc ||
        itemsLength != oldDelegate.itemsLength ||
        hasLabel != oldDelegate.hasLabel ||
        borderColor != oldDelegate.borderColor ||
        borderWidth != oldDelegate.borderWidth;
  }
}
