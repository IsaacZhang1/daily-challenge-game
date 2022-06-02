import 'package:daily_game_challenge/screens/widgets/daily_game.dart';
import 'package:daily_game_challenge/utils/vertical_space.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool playable;
  final int? currentScore;
  final int? highScore;

  const HomeScreen({
    Key? key,
    required this.playable,
    this.currentScore,
    this.highScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: playable
          ? const GameCanvas()
          : WaitingScreen(
              currentScore: currentScore,
              highScore: highScore,
            ),
    );
  }
}

class GameCanvas extends StatefulWidget {
  const GameCanvas({Key? key}) : super(key: key);

  @override
  State<GameCanvas> createState() => _GameCanvasState();
}

class _GameCanvasState extends State<GameCanvas> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return isPlaying
        ? const DailyGame(
            diameter: 250,
            durationInMilliseconds: 4000,
          )
        : Center(
            child: ElevatedButton(
              child: const Text('Start Game'),
              onPressed: () {
                setState(() {
                  isPlaying = true;
                });
              },
            ),
          );
  }
}

class WaitingScreen extends StatelessWidget {
  final int? currentScore;
  final int? highScore;

  const WaitingScreen({
    Key? key,
    required this.currentScore,
    required this.highScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: const Text(
            'Try again tomorrow!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalSpace(byFactorOf: 4),
        Text(
          'Today: ${currentScore.toString()}',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VerticalSpace(byFactorOf: 4),
        Text(
          'High score: ${highScore.toString()}',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
