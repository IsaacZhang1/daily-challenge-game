import 'package:daily_game_challenge/screens/end_game_popup.dart';
import 'package:daily_game_challenge/screens/widgets/circle.dart';
import 'package:daily_game_challenge/screens/widgets/expanding_widgets.dart';
import 'package:daily_game_challenge/utils/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyGame extends StatefulWidget {
  final double diameter;
  final int durationInMilliseconds;

  const DailyGame({
    Key? key,
    required this.diameter,
    required this.durationInMilliseconds,
  }) : super(key: key);

  @override
  State<DailyGame> createState() => _DailyGameState();
}

class _DailyGameState extends State<DailyGame> {
  List<Widget> gameObjects = [];

  late Widget currentAnimation;
  late GlobalKey<ExpandingCircleAnimationState> _myKey;
  double previousValue = 0.0;

  final gameType = GameType.increasing;

  int score = 0;

  @override
  void initState() {
    super.initState();

    _myKey = GlobalKey();
    currentAnimation = ExpandingCircleAnimation(
      key: _myKey,
      diameter: widget.diameter,
      durationInMilliseconds: widget.durationInMilliseconds,
    );
    gameObjects.add(Circle(diameter: widget.diameter + 3));
    gameObjects.add(currentAnimation);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpace(byFactorOf: 4),
          Text(
            score.toString(),
            style: const TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: screenWidth,
            width: screenWidth,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ...gameObjects,
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onUserTap,
            child: Circle(
              diameter: 115,
              borderColor: Colors.grey,
              borderWidth: 10.0,
              fillColor: Colors.red,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red.shade400,
                  Colors.red.shade900,
                ],
              ),
            ),
          ),
          const VerticalSpace(byFactorOf: 10),
        ],
      ),
    );
  }

  void onUserTap() {
    final value = _myKey.currentState!.stopGame();
    setState(() {
      if (shouldContinue(value: value, gameType: gameType)) {
        score += 1;
        previousValue = value;
        _myKey = GlobalKey();
        currentAnimation = ExpandingCircleAnimation(
          key: _myKey,
          diameter: widget.diameter,
          durationInMilliseconds: widget.durationInMilliseconds,
        );
        gameObjects.add(currentAnimation);
        return;
      }
      _myKey.currentState!.setGameOver();
      onEndGame();
    });
  }

  bool shouldContinue({
    required double value,
    required GameType gameType,
  }) {
    switch (gameType) {
      case GameType.increasing:
        {
          return value > previousValue;
        }
    }
  }

  void onEndGame() async {
    print('iz: ending game');
    final highScore = await storeSharedPreferences();
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (_) => EndGamePopup(
        score: score,
        highScore: highScore,
      ),
    );
  }

  Future<int> storeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final date = DateTime.now();
    prefs.setString('lastPlayedDate', date.toIso8601String());
    prefs.setInt('currentScore', score);
    var highScore = prefs.getInt('highScore') ?? 0;
    if (highScore == 0 || score > highScore) {
      prefs.setInt('highScore', score);
      highScore = score;
    }
    return highScore;
  }
}

enum GameType {
  increasing,
}
