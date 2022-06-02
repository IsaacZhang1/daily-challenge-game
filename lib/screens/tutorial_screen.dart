import 'package:daily_game_challenge/utils/vertical_space.dart';
import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const fontSize = 16.0;
    return Dialog(
      child: IntrinsicHeight(
        child: SizedBox(
          width: screenWidth - 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  VerticalSpace(byFactorOf: 2),
                  Center(
                    child: Text(
                      'How do I play?',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  VerticalSpace(byFactorOf: 3),
                  Text(
                    'The game is simple.',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  VerticalSpace(byFactorOf: 2),
                  Text(
                    'Super simple.',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  VerticalSpace(byFactorOf: 2),
                  Text(
                    'Just tap the red button to lock in your circle.',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  VerticalSpace(byFactorOf: 2),
                  Text(
                    'Each subsequent circle must be larger than the previous.',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  VerticalSpace(byFactorOf: 2),
                  Text(
                    'The more circles, the higher your score.',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  VerticalSpace(byFactorOf: 2),
                  Text(
                    'Beat your friends.',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  VerticalSpace(byFactorOf: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
