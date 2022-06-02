import 'package:daily_game_challenge/screens/widgets/circle.dart';
import 'package:daily_game_challenge/utils/app_colors.dart';
import 'package:flutter/material.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Circle(
            diameter: 200,
            borderColor: AppColors.startGameButtonBorder,
            borderWidth: 10.0,
            fillColor: AppColors.startGameButton,
          ),
          const Text(
            'Start game',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
