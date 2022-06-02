import 'package:daily_game_challenge/screens/tutorial_screen.dart';
import 'package:daily_game_challenge/screens/widgets/daily_game.dart';
import 'package:daily_game_challenge/utils/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class HomeScreen extends StatefulWidget {
  final bool playable;
  final bool isFirstLoad;
  final int? currentScore;
  final int? highScore;

  const HomeScreen({
    Key? key,
    required this.playable,
    required this.isFirstLoad,
    this.currentScore,
    this.highScore,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool playable;
  late bool isFirstLoad;

  @override
  void initState() {
    super.initState();
    initUserState();
    playable = widget.playable;
  }

  void initUserState() {
    isFirstLoad = widget.isFirstLoad;
  }

  void showTutorial() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const TutorialScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLoad) {
      isFirstLoad = false;
      Future.delayed(const Duration(milliseconds: 500), () => showTutorial());
    }
    return Scaffold(
      body: playable
          ? const GameCanvas()
          : WaitingScreen(
              currentScore: widget.currentScore,
              highScore: widget.highScore,
              onNewDay: () => onNewDay(),
            ),
    );
  }

  void onNewDay() {
    print('iz: onNewDay');
    setState(() {
      playable = true;
    });
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownTimer(
          endTime: DateTime(currentDate.year, currentDate.month, currentDate.day + 1).millisecondsSinceEpoch,
          textStyle: const TextStyle(
            fontSize: 30,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          onEnd: () => onNewDay(),
        ),
        const VerticalSpace(byFactorOf: 4),
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
