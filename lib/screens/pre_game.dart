import 'package:checkers/screens/chess_board.dart';
import 'package:checkers/utils/constants.dart';
import 'package:checkers/screens/profile.dart';
import 'package:checkers/utils/buttons.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../widgets/country_chooser.dart';
import '../widgets/level_chooser.dart';
import '../widgets/statistics_header.dart';

class PreGame extends StatelessWidget {
  final int? opponent;

  const PreGame({
    Key? key,
    this.opponent = Opponent.humanOffline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/background3.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.brown.withOpacity(0.9),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kBoardDark,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: kWoodenBrown,
                      weight: 60,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const StatisticsHead(),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 200),
            Text(
              Opponent.names[opponent!],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 40),
            const CountryChooser(),
            const SizedBox(height: 20),
            opponent == Opponent.humanOffline
                ? _vsHumanOffline(context)
                : opponent == Opponent.humanOnline
                    ? _vsHumanOnline(context)
                    : _vsComputer(context),
            const SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle1,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChessBoard(
                      opponent: opponent ?? Opponent.humanOffline,
                    ),
                  ),
                );
              },
              child: const Text('Play'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vsHumanOffline(BuildContext context) {
    return Column(
      children: [],
    );
  }

  Widget _vsHumanOnline(BuildContext context) {
    return Column(
      children: [],
    );
  }

  Widget _vsComputer(BuildContext context) {
    return Column(
      children: [
        LevelChooser(),
      ],
    );
  }
}
