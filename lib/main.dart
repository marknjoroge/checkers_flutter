import 'package:checkers/screens/pre_game.dart';
import 'package:checkers/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

import 'screens/chess_board.dart';
import 'screens/test.dart';

void main() {
  // hide status bar and navigation bar
  runApp(const MyApp());
  // SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkers Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // home: ProfilePage(),
      home: const PreGame(),
      // home: const Home(),
      // home: const ChessBoard(),
      // home: const Test()
    );
  }
}
