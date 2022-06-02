import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double diameter;
  final Color borderColor;
  final Color? fillColor;
  final double borderWidth;
  final LinearGradient? gradient;

  const Circle({
    Key? key,
    required this.diameter,
    this.borderColor = Colors.green,
    this.fillColor,
    this.borderWidth = 3.0,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        gradient: gradient,
        shape: BoxShape.circle,
        color: fillColor,
      ),
    );
  }
}
