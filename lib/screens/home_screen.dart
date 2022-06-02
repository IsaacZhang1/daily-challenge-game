import 'package:daily_game_challenge/screens/tutorial_screen.dart';
import 'package:daily_game_challenge/screens/waiting_screen.dart';
import 'package:daily_game_challenge/screens/widgets/circle.dart';
import 'package:daily_game_challenge/screens/widgets/daily_game.dart';
import 'package:daily_game_challenge/screens/widgets/start_game_button.dart';
import 'package:daily_game_challenge/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AppColors.backgroundColor,
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
        ? const DailyGame()
        : GestureDetector(
            onTap: () {
              setState(() {
                isPlaying = true;
              });
            },
            child: const StartGameButton(),
          );
  }
}
