import 'package:flutter/material.dart';

/// Theme data for [GlazeNavBar].
///
/// Use this to customize the appearance of all [GlazeNavBar] widgets
/// in your app through the theme system.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       GlazeNavBarThemeData(
///         color: Colors.purple,
///         glassBlur: 25,
///       ),
///     ],
///   ),
/// )
/// ```
@immutable
class GlazeNavBarThemeData extends ThemeExtension<GlazeNavBarThemeData> {
  /// Creates a theme data for [GlazeNavBar].
  const GlazeNavBarThemeData({
    this.color,
    this.buttonBackgroundColor,
    this.backgroundColor,
    this.gradient,
    this.buttonGradient,
    this.glassBorderColor,
    this.buttonBorderColor,
    this.glassBlur,
    this.glassOpacity,
    this.glassBorderRadius,
    this.glassBorderWidth,
    this.buttonBorderWidth,
    this.height,
    this.iconPadding,
    this.animationDuration,
    this.animationCurve,
  });

  /// The primary color of the navigation bar.
  final Color? color;

  /// Background color of the floating button.
  final Color? buttonBackgroundColor;

  /// Background color behind the navigation bar.
  final Color? backgroundColor;

  /// Gradient for the navigation bar (overrides [color]).
  final Gradient? gradient;

  /// Gradient for the floating button.
  final Gradient? buttonGradient;

  /// Border color for the glass effect.
  final Color? glassBorderColor;

  /// Border color for the floating button.
  final Color? buttonBorderColor;

  /// Blur intensity for the glass effect.
  final double? glassBlur;

  /// Opacity of the glass background.
  final double? glassOpacity;

  /// Border radius for the glass effect.
  final double? glassBorderRadius;

  /// Border width for the glass effect.
  final double? glassBorderWidth;

  /// Border width for the floating button.
  final double? buttonBorderWidth;

  /// Height of the navigation bar.
  final double? height;

  /// Padding around the floating icon.
  final double? iconPadding;

  /// Duration of animations.
  final Duration? animationDuration;

  /// Curve for animations.
  final Curve? animationCurve;

  @override
  GlazeNavBarThemeData copyWith({
    Color? color,
    Color? buttonBackgroundColor,
    Color? backgroundColor,
    Gradient? gradient,
    Gradient? buttonGradient,
    Color? glassBorderColor,
    Color? buttonBorderColor,
    double? glassBlur,
    double? glassOpacity,
    double? glassBorderRadius,
    double? glassBorderWidth,
    double? buttonBorderWidth,
    double? height,
    double? iconPadding,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return GlazeNavBarThemeData(
      color: color ?? this.color,
      buttonBackgroundColor:
          buttonBackgroundColor ?? this.buttonBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      glassBorderColor: glassBorderColor ?? this.glassBorderColor,
      buttonBorderColor: buttonBorderColor ?? this.buttonBorderColor,
      glassBlur: glassBlur ?? this.glassBlur,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      glassBorderRadius: glassBorderRadius ?? this.glassBorderRadius,
      glassBorderWidth: glassBorderWidth ?? this.glassBorderWidth,
      buttonBorderWidth: buttonBorderWidth ?? this.buttonBorderWidth,
      height: height ?? this.height,
      iconPadding: iconPadding ?? this.iconPadding,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  @override
  GlazeNavBarThemeData lerp(GlazeNavBarThemeData? other, double t) {
    if (other is! GlazeNavBarThemeData) return this;
    return GlazeNavBarThemeData(
      color: Color.lerp(color, other.color, t),
      buttonBackgroundColor:
          Color.lerp(buttonBackgroundColor, other.buttonBackgroundColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      gradient: Gradient.lerp(gradient, other.gradient, t),
      buttonGradient: Gradient.lerp(buttonGradient, other.buttonGradient, t),
      glassBorderColor: Color.lerp(glassBorderColor, other.glassBorderColor, t),
      buttonBorderColor:
          Color.lerp(buttonBorderColor, other.buttonBorderColor, t),
      glassBlur: lerpDouble(glassBlur, other.glassBlur, t),
      glassOpacity: lerpDouble(glassOpacity, other.glassOpacity, t),
      glassBorderRadius:
          lerpDouble(glassBorderRadius, other.glassBorderRadius, t),
      glassBorderWidth: lerpDouble(glassBorderWidth, other.glassBorderWidth, t),
      buttonBorderWidth:
          lerpDouble(buttonBorderWidth, other.buttonBorderWidth, t),
      height: lerpDouble(height, other.height, t),
      iconPadding: lerpDouble(iconPadding, other.iconPadding, t),
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
    );
  }

  /// Resolves the theme data with fallbacks from [ThemeData].
  ///
  /// This method provides sensible defaults based on the current theme
  /// when specific values are not set.
  GlazeNavBarThemeData resolve(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GlazeNavBarThemeData(
      color: color ?? colorScheme.surface,
      buttonBackgroundColor:
          buttonBackgroundColor ?? colorScheme.primaryContainer,
      backgroundColor: backgroundColor ?? Colors.transparent,
      gradient: gradient,
      buttonGradient: buttonGradient,
      glassBorderColor:
          glassBorderColor ?? colorScheme.outline.withValues(alpha: 0.3),
      buttonBorderColor:
          buttonBorderColor ?? colorScheme.outline.withValues(alpha: 0.5),
      glassBlur: glassBlur ?? 20,
      glassOpacity: glassOpacity ?? 0.2,
      glassBorderRadius: glassBorderRadius ?? 0,
      glassBorderWidth: glassBorderWidth ?? 1.5,
      buttonBorderWidth: buttonBorderWidth ?? 3.0,
      height: height ?? 75.0,
      iconPadding: iconPadding ?? 12.0,
      animationDuration: animationDuration ?? const Duration(milliseconds: 600),
      animationCurve: animationCurve ?? Curves.easeOut,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is GlazeNavBarThemeData &&
        other.color == color &&
        other.buttonBackgroundColor == buttonBackgroundColor &&
        other.backgroundColor == backgroundColor &&
        other.gradient == gradient &&
        other.buttonGradient == buttonGradient &&
        other.glassBorderColor == glassBorderColor &&
        other.buttonBorderColor == buttonBorderColor &&
        other.glassBlur == glassBlur &&
        other.glassOpacity == glassOpacity &&
        other.glassBorderRadius == glassBorderRadius &&
        other.glassBorderWidth == glassBorderWidth &&
        other.buttonBorderWidth == buttonBorderWidth &&
        other.height == height &&
        other.iconPadding == iconPadding &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve;
  }

  @override
  int get hashCode => Object.hash(
        color,
        buttonBackgroundColor,
        backgroundColor,
        gradient,
        buttonGradient,
        glassBorderColor,
        buttonBorderColor,
        glassBlur,
        glassOpacity,
        glassBorderRadius,
        glassBorderWidth,
        buttonBorderWidth,
        height,
        iconPadding,
        animationDuration,
        animationCurve,
      );
}

/// An inherited widget that provides [GlazeNavBarThemeData] to its descendants.
///
/// This allows you to theme [GlazeNavBar] widgets in a subtree without
/// using [ThemeExtension].
class GlazeNavBarTheme extends InheritedTheme {
  /// Creates a [GlazeNavBarTheme].
  const GlazeNavBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The theme data for [GlazeNavBar] widgets.
  final GlazeNavBarThemeData data;

  /// Returns the [GlazeNavBarThemeData] from the closest [GlazeNavBarTheme]
  /// ancestor, or from the [ThemeData.extensions] if no ancestor is found.
  ///
  /// Returns `null` if no theme data is available.
  static GlazeNavBarThemeData? maybeOf(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<GlazeNavBarTheme>();
    return theme?.data ?? Theme.of(context).extension<GlazeNavBarThemeData>();
  }

  /// Returns the [GlazeNavBarThemeData] from the closest [GlazeNavBarTheme]
  /// ancestor, from [ThemeData.extensions], or a default theme if none is found.
  static GlazeNavBarThemeData of(BuildContext context) {
    return maybeOf(context) ?? const GlazeNavBarThemeData();
  }

  @override
  bool updateShouldNotify(GlazeNavBarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GlazeNavBarTheme(data: data, child: child);
  }
}
