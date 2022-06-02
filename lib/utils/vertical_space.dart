import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double byFactorOf;

  const VerticalSpace({
    Key? key,
    this.byFactorOf = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.0 * byFactorOf,
      width: double.infinity,
    );
  }
}
