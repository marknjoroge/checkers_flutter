import 'package:checkers/screens/pre_game.dart';
import 'package:checkers/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

import 'screens/chess_board.dart';

void main() {
  // hide status bar and navigation bar
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkers Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // home: ProfilePage(),
      home: const ChessBoard(),
    );
  }
}
