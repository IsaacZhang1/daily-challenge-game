import 'package:daily_game_challenge/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getUserState();
  }

  void getUserState() async {
    final prefs = await SharedPreferences.getInstance();

    final lastPlayedDate = prefs.getString('lastPlayedDate');
    final currentScore = prefs.getInt('currentScore');
    final highScore = prefs.getInt('highScore');

    bool playable = true;

    // Check if the user already attempted today
    if (lastPlayedDate != null) {
      DateTime lastPlayed = DateTime.parse(lastPlayedDate);
      final currentDate = DateTime.now();
      if (lastPlayed.day == currentDate.day && lastPlayed.month == currentDate.month && lastPlayed.year == currentDate.year) {
        playable = false;
      }
    }

    final isFirstLoad = prefs.getBool('isFirstLoad') ?? true;
    if (isFirstLoad) {
      prefs.setBool('isFirstLoad', false);
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            playable: playable,
            currentScore: currentScore,
            highScore: highScore,
            isFirstLoad: isFirstLoad,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
