import 'package:daily_game_challenge/utils/app_colors.dart';
import 'package:daily_game_challenge/utils/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class WaitingScreen extends StatelessWidget {
  final int? currentScore;
  final int? highScore;
  final VoidCallback onNewDay;

  const WaitingScreen({
    Key? key,
    required this.currentScore,
    required this.highScore,
    required this.onNewDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpace(byFactorOf: 6),
          CountdownTimer(
            endTime: DateTime(currentDate.year, currentDate.month, currentDate.day + 1).millisecondsSinceEpoch,
            textStyle: TextStyle(
              fontSize: 40,
              color: AppColors.countdownTimer,
              fontWeight: FontWeight.bold,
            ),
            onEnd: () => onNewDay(),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppColors.waitingContainer,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: const Text(
              'Try again tomorrow!',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VerticalSpace(byFactorOf: 5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppColors.waitingContainer2,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Text(
              'Today: ${currentScore.toString()}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const VerticalSpace(byFactorOf: 5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppColors.waitingContainer2,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Text(
              'High score: ${highScore.toString()}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
