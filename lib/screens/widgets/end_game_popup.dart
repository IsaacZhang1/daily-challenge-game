import 'package:daily_game_challenge/utils/vertical_space.dart';
import 'package:flutter/material.dart';

class EndGamePopup extends StatelessWidget {
  final int score;
  final int highScore;

  const EndGamePopup({
    Key? key,
    required this.score,
    required this.highScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      child: IntrinsicHeight(
        child: SizedBox(
          width: screenWidth - 20,
          child: Column(
            children: [
              const VerticalSpace(byFactorOf: 6),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Text(
                  'Score',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const VerticalSpace(byFactorOf: 3),
              Text(
                score.toString(),
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpace(byFactorOf: 4),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: const Text(
                  'High Score',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const VerticalSpace(byFactorOf: 3),
              Text(
                highScore.toString(),
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpace(byFactorOf: 6),
            ],
          ),
        ),
      ),
    );
  }
}
