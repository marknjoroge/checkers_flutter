import 'package:flutter/material.dart';

const Color kWoodenBrown = Color.fromRGBO(193, 154, 107, 1);
const Color kWoodenBrownLight = Color.fromRGBO(193, 154, 107, 0.3);

const Color kBoardDark = Color.fromRGBO(67,74,84,1);
const Color kBoardLight = kPieceLight;

const Color kPieceLight = Color.fromRGBO(230, 233, 237, 1);
const Color kPieceDark = Color.fromRGBO(150, 83, 83, 1);

const double kPlayerOpacity = 0.2;

const String kBackground = 'assets/images/background3.jpg';


class Opponent {
  static const int humanOnline = 0;
  static const int humanOffline = 1;
  static const int computer = 2;

  static const List<String> names = [
    'vs Human Online',
    'vs Human Offline',
    'vs Computer',
  ];
}

class Level {
  static const int beginner = 0;
  static const int intermediate = 1;
  static const int advanced = 2;

  static const List<String> names = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
}

class GameType {
  static const int american = 0;
  static const int turkish = 1;
  static const int russian = 2;
  static const int czech = 3;
  static const int italian = 4;
  static const int international = 5;

  static const List<String> names = [
    'American',
    'Turkish',
    'Russian',
    'Czech',
    'Italian',
    'International',
  ];
}

