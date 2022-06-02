import 'package:flutter/material.dart';

class ExpandingContainer extends AnimatedWidget {
  final double diamter;
  final Color borderColor;

  const ExpandingContainer({
    Key? key,
    required AnimationController controller,
    required this.diamter,
    required this.borderColor,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diamter * _progress.value,
      height: diamter * _progress.value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
        ),
      ),
    );
  }
}

class ExpandingCircleAnimation extends StatefulWidget {
  final double diameter;
  final int durationInMilliseconds;

  const ExpandingCircleAnimation({
    Key? key,
    required this.diameter,
    required this.durationInMilliseconds,
  }) : super(key: key);

  @override
  State<ExpandingCircleAnimation> createState() => ExpandingCircleAnimationState();
}

class ExpandingCircleAnimationState extends State<ExpandingCircleAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: widget.durationInMilliseconds),
    vsync: this,
  )..repeat();

  Color borderColor = Colors.green;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double stopGame() {
    _controller.stop();
    setState(() {
      borderColor = Colors.blue;
    });
    return _controller.value * widget.diameter;
  }

  void setGameOver() {
    setState(() {
      borderColor = Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpandingContainer(
      controller: _controller,
      diamter: widget.diameter,
      borderColor: borderColor,
    );
  }
}
