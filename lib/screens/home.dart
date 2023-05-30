import 'package:checkers/screens/pre_game.dart';
import 'package:checkers/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../widgets/statistics_header.dart';
import 'profile.dart';
import '../utils/buttons.styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/background3.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.brown.withOpacity(0.9), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            StatisticsHead(),
            const SizedBox(height: 200),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: buttonStyle1,
                      onPressed: () {
                        gameDialog(context);
                      },
                      child: const Text('New Game'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: buttonStyle1,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: const Hero(
                        tag: 'profile',
                        child: Text('Profile & Statistics'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future gameDialog(BuildContext context) async {
  return showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: buttonStyle2,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PreGame(
                          opponent: Opponent.computer,
                        ),
                      ),
                    );
                  },
                  child: const Text('vs Computer'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: buttonStyle2,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PreGame(
                          opponent: Opponent.humanOffline,
                        ),
                      ),
                    );
                  },
                  child: const Hero(
                    tag: 'btnVsHumanOffline',
                    child: Text('vs Human (offline)'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: buttonStyle2,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PreGame(
                          opponent: Opponent.humanOnline,
                        ),
                      ),
                    );
                  },
                  child: const Text('vs Human (online)'),
                ),
              ),
            ],
          ),
        ),
      );
    },
    animationType: DialogTransitionType.slideFromTopFade,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(seconds: 1),
  );
}
