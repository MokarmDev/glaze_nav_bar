import 'package:flutter/cupertino.dart';

class NavCustomClipper extends CustomClipper<Rect> {
  final double deviceHeight;

  NavCustomClipper({required this.deviceHeight});

  @override
  Rect getClip(Size size) {
    // Create a large enough clip rect to allow the floating button to be visible
    // above the navigation bar without causing geometry assertion errors
    final double extraHeight = 100.0; // Extra space for the floating button
    return Rect.fromLTWH(
      0,
      -extraHeight,
      size.width,
      size.height + extraHeight,
    );
  }

  @override
  bool shouldReclip(NavCustomClipper oldClipper) {
    return oldClipper.deviceHeight != deviceHeight;
  }
}
