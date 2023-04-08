import 'package:checkers/screens/chess_board.dart';
import 'package:checkers/utils/constants.dart';
import 'package:checkers/screens/profile.dart';
import 'package:checkers/utils/buttons.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../widgets/country_chooser.dart';
import '../widgets/statistics_header.dart';

class PreGame extends StatefulWidget {
  const PreGame({super.key});

  @override
  State<PreGame> createState() => _PreGameState();
}

class _PreGameState extends State<PreGame> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/background3.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.brown.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
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
                    child: Icon(
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
                StatisticsHead(),
                SizedBox(width: 50),
              ],
            ),
            SizedBox(height: 200),
            Hero(
              tag: 'btnVsHumanOffline',
              child: Text('vs Human (offline)'),
            ),
            SizedBox(height: 20),
            CountryChooser(),
            SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle1,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChessBoard(),
                  ),
                );
              },
              child: Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
