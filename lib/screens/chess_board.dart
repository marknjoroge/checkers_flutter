import 'dart:math';

import 'package:checkers/utils/game_play/rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../utils/constants.dart';
import '../widgets/pawn.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  final int rows = 8;
  final int columns = 8;

  String turn = 'white';

  var activeTile = '';

  final StopWatchTimer _whiteTimer = StopWatchTimer();
  final StopWatchTimer _blackTimer = StopWatchTimer();

  var gameRules = AmericanCheckers();

  List<String> blackStartingPositions = [
    '01',
    '03',
    '05',
    '07',
    '10',
    '12',
    '14',
    '16',
    '21',
    '23',
    '25',
    '27'
  ];

  List<String> whiteStartingPositions = [
    '50',
    '52',
    '54',
    '56',
    '61',
    '63',
    '65',
    '67',
    '70',
    '72',
    '74',
    '76'
  ];

  List<String> blackPawnsPositions = [];
  List<String> whitePawnsPositions = [];

  List<String> blackKingsPositions = [];
  List<String> whiteKingsPositions = [];

  List<String> allBlackPositions = [];
  List<String> allWhitePositions = [];

  List<Map> log = [];

  List<String> possibleMoves = [];
  List<Map> possibleEat = [];

  int whiteScore = 0;
  int blackScore = 0;

  /// Helper functions

  void scores() {
    setState(() {
      allBlackPositions.clear();
      allWhitePositions.clear();

      allBlackPositions = blackPawnsPositions + blackKingsPositions;
      allWhitePositions = whitePawnsPositions + whiteKingsPositions;

      whiteScore = 12 - allBlackPositions.length;
      blackScore = 12 - allWhitePositions.length;
    });

    // if (whiteScore == 12) {
    // } else if (blackScore == 12) {}
  }

  void checkIfGameWon(BuildContext context) {
    if (whiteScore == 12) {
      stopTimers();
      customDialog(context, 'white');
    } else if (blackScore == 12) {
      stopTimers();
      customDialog(context, 'black');
    }
  }

  void changeTimer() {
    if (turn == 'white') {
      _whiteTimer.onStartTimer();
      _blackTimer.onStopTimer();
    } else {
      _blackTimer.onStartTimer();
      _whiteTimer.onStopTimer();
    }
  }

  void stopTimers() {
    _whiteTimer.onStopTimer();
    _blackTimer.onStopTimer();
  }

  bool checkIfKing(String position, String turn) {
    return ((position.substring(0, 1) == '0' && turn == 'white') ||
        (position.substring(0, 1) == '7' && turn == 'black'));
  }

  bool isValidPosition(String position) {
    if (position.length != 2) return false;

    int row = int.parse(position[0]);
    int col = int.parse(position[1]);

    if (row >= 0 && row <= 7 && col >= 0 && col <= 7) {
      return true;
    }

    return false;
  }

  bool isEmptyTile(String position) {
    if (blackPawnsPositions.contains(position) ||
        whitePawnsPositions.contains(position) ||
        blackKingsPositions.contains(position) ||
        whiteKingsPositions.contains(position)) {
      return false;
    }

    return true;
  }

  String canBeEatenByPawn(String position, {String tile = ''}) {
    String myTile = activeTile;
    // if (tile != '') myTile = tile;

    // print('tile: $myTile, position: $position, activeTile: $activeTile, turn: $turn');
    int rowDiff = int.parse(myTile[0]) - int.parse(position[0]);
    int colDiff = int.parse(myTile[1]) - int.parse(position[1]);

    int rowAfterJump = int.parse(position[0]) - rowDiff;
    int colAfterJump = int.parse(position[1]) - colDiff;

    if (isValidPosition('$rowAfterJump$colAfterJump')) {
      if (isEmptyTile('$rowAfterJump$colAfterJump')) {
        return '$rowAfterJump$colAfterJump';
      }
    }

    return '';
  }

  List<String> getNextPawnMoves(String currentPosition) {
    int row = int.parse(currentPosition[0]);
    int col = int.parse(currentPosition[1]);

    // Define the possible directions a piece can move on the board
    List<int> directions = [-1, 1];

    // Initialize the list of next moves
    List<String> nextMoves = [];

    // Check all possible moves in each direction
    for (int rowDir in directions) {
      for (int colDir in directions) {
        int nextRow = row + rowDir;
        int nextCol = col + colDir;

        // Check if the next move is within the bounds of the board
        if (isValidPosition('$nextRow$nextCol')) {
          // Add the next move to the list
          String nextPosition = '$nextRow$nextCol';
          nextMoves.add(nextPosition);
        }
      }
    }

    scores();

    return nextMoves;
  }

  List<String> getRefinedNextMoves(List<String> moves) {
    List<String> refinedMoves = [];
    possibleEat.clear();

    // print('moves: $moves');

    for (String move in moves) {
      if (turn == 'white') {
        if (whitePawnsPositions.contains(move) ||
            whiteKingsPositions.contains(move)) {
          continue;
        } else if (blackPawnsPositions.contains(move) ||
            blackKingsPositions.contains(move)) {
          if (canBeEatenByPawn(move) != '') {
            refinedMoves.add(canBeEatenByPawn(move));
            possibleEat.add({'moveTo': canBeEatenByPawn(move), 'eat': move});
            setState(() {});
          }
        } else {
          refinedMoves.add(move);
        }
      } else {
        if (blackPawnsPositions.contains(move) ||
            blackKingsPositions.contains(move)) {
          continue;
        } else if (whitePawnsPositions.contains(move) ||
            whiteKingsPositions.contains(move)) {
          if (canBeEatenByPawn(move) != '') {
            refinedMoves.add(canBeEatenByPawn(move));
            possibleEat.add({'moveTo': canBeEatenByPawn(move), 'eat': move});
            setState(() {});
          }
        } else {
          refinedMoves.add(move);
        }
      }
    }

    refinedMoves = gameRules.normalPawnMoves(refinedMoves, activeTile, turn);

    return refinedMoves;
  }

  List<String> getNextKingMoves(String position) {
    List<String> diagonals = [];

    possibleEat.clear();

    diagonals = calcLegalDiagonals(position, 1, 1);
    diagonals.addAll(calcLegalDiagonals(position, 1, -1));
    diagonals.addAll(calcLegalDiagonals(position, -1, 1));
    diagonals.addAll(calcLegalDiagonals(position, -1, -1));

    return diagonals;
  }

  List<String> calcLegalDiagonals(String position, int pRow, int pCol) {
    List<String> diagonals = [];
    int row = int.parse(position[0]) + pRow;
    int col = int.parse(position[1]) + pCol;

    while (isValidPosition('$row$col')) {
      // print('row: $row, col: $col');
      if (turn == 'white') {
        if (allWhitePositions.contains('$row$col')) {
          break;
        }
        if (allBlackPositions.contains('$row$col')) {
          if (isEmptyTile('${row + pRow}${col + pCol}')) {
            possibleEat.add(
                {'moveTo': '${row + pRow}${col + pCol}', 'eat': '$row$col'});
            diagonals.add('${row + pRow}${col + pCol}');
          }
          break;
        }
        diagonals.add('$row$col');
      } else if (turn == 'black') {
        if (allBlackPositions.contains('$row$col')) {
          break;
        }
        if (allWhitePositions.contains('$row$col')) {
          if (isEmptyTile('${row + pRow}${col + pCol}')) {
            possibleEat.add(
                {'moveTo': '${row + pRow}${col + pCol}', 'eat': '$row$col'});
            diagonals.add('${row + pRow}${col + pCol}');
          }
          break;
        }
        diagonals.add('$row$col');
      }

      row += pRow;
      col += pCol;
    }

    return diagonals;
  }

  void movePawn(String position) {
    String eaten = '';
    String color = turn;

    print('possibleEat: $possibleEat');

    if (turn == 'white') {
      whitePawnsPositions.remove(activeTile);
      whitePawnsPositions.add(position);
      turn = 'black';
      if (possibleEat.any((eat) => eat['moveTo'] == position)) {
        eaten =
            possibleEat.firstWhere((eat) => eat['moveTo'] == position)['eat'];

        blackPawnsPositions.remove(eaten);
        blackKingsPositions.remove(eaten);
      }
    } else {
      blackPawnsPositions.remove(activeTile);
      blackPawnsPositions.add(position);
      turn = 'white';
      if (possibleEat.any((eat) => eat['moveTo'] == position)) {
        eaten =
            possibleEat.firstWhere((eat) => eat['moveTo'] == position)['eat'];

        whiteKingsPositions.remove(eaten);
        whitePawnsPositions.remove(eaten);
      }
    }

    if (checkIfKing(position, color)) {
      if (color == 'white') {
        whitePawnsPositions.remove(position);
        whiteKingsPositions.add(position);
      } else {
        blackPawnsPositions.remove(position);
        blackKingsPositions.add(position);
      }
    }

    log.add({'from': activeTile, 'to': position, 'color': color, 'eat': eaten});

    activeTile = '';
    possibleMoves = [];
    scores();
    changeTimer();
  }

  void moveKing(String position) {
    String eaten = '';
    String color = turn;

    if (turn == 'white') {
      whiteKingsPositions.remove(activeTile);
      whiteKingsPositions.add(position);
      turn = 'black';
      if (possibleEat.any((eat) => eat['moveTo'] == position)) {
        eaten =
            possibleEat.firstWhere((eat) => eat['moveTo'] == position)['eat'];

        blackPawnsPositions.remove(eaten);
        blackKingsPositions.remove(eaten);
      }
    } else {
      blackKingsPositions.remove(activeTile);
      blackKingsPositions.add(position);
      turn = 'white';
      if (possibleEat.any((eat) => eat['moveTo'] == position)) {
        eaten =
            possibleEat.firstWhere((eat) => eat['moveTo'] == position)['eat'];

        whitePawnsPositions.remove(eaten);
        whiteKingsPositions.remove(eaten);
      }
    }

    log.add(
        {'from': activeTile, 'to': position, 'color': 'k$color', 'eat': eaten});

    activeTile = '';
    possibleMoves = [];
    scores();
    changeTimer();
  }

  void eatPawn(String position) {
    if (turn == 'white') {
      // if (possibleEat.any((eat) => eat['eat'] == 'B3'))
      whitePawnsPositions.remove(activeTile);
      whitePawnsPositions.add(position);
      blackPawnsPositions.remove(position);
      turn = 'black';
    } else {
      blackPawnsPositions.remove(activeTile);
      blackPawnsPositions.add(position);
      whitePawnsPositions.remove(position);
      turn = 'white';
    }

    activeTile = '';
    possibleMoves = [];
    scores();
    changeTimer();
  }

  void undoMove() {
    if (log.isNotEmpty) {
      Map lastMove = log.last;
      log.removeLast();

      if (lastMove['color'] == 'white') {
        whitePawnsPositions.removeLast();
        whitePawnsPositions.add(lastMove['from']);
        if (lastMove['eat'] != '') {
          blackPawnsPositions.add(lastMove['eat']);
        }
        turn = 'white';
      } else if (lastMove['color'] == 'black') {
        blackPawnsPositions.removeLast();
        blackPawnsPositions.add(lastMove['from']);
        if (lastMove['eat'] != '') {
          whitePawnsPositions.add(lastMove['eat']);
        }
        turn = 'black';
      } else if (lastMove['color'] == 'kwhite') {
        whiteKingsPositions.removeLast();
        whiteKingsPositions.add(lastMove['from']);
        if (lastMove['eat'] != '') {
          blackPawnsPositions.add(lastMove['eat']);
        }
        turn = 'white';
      } else if (lastMove['color'] == 'kblack') {
        blackKingsPositions.removeLast();
        blackKingsPositions.add(lastMove['from']);
        if (lastMove['eat'] != '') {
          whitePawnsPositions.add(lastMove['eat']);
        }
        turn = 'black';
      }
    }

    setState(() {});
    scores();
  }

  Map<String, List<String>> getAllNextPawnMoves(
      List<String> pawns, List<String> kings) {
    Map<String, List<String>> allNextMoves = {};

    for (String pawn in pawns) {
      activeTile = pawn;
      List<String> nextMoves = getNextPawnMoves(pawn);
      nextMoves = getRefinedNextMoves(nextMoves);
      allNextMoves[pawn] = nextMoves;
    }

    for (String king in kings) {
      List<String> nextMoves = getNextKingMoves(king);
      print('kingMoves: $nextMoves');
      allNextMoves[king] = nextMoves;
    }

    activeTile = '';

    allNextMoves.removeWhere((key, value) => value.isEmpty);

    return allNextMoves;
  }

  Map<String, List<String>> getEatingMoves(Map<String, List<String>> myMoves) {
    Map<String, List<String>> eatingMoves = {};

    possibleEat.clear();

    for (String pawn in myMoves.keys) {
      List<String> nextMoves = myMoves[pawn]!;
      List<String> eating = [];

      String eatable = '';

      activeTile = pawn;

      for (String move in nextMoves) {
        int rowDiff = int.parse(pawn[0]) - int.parse(move[0]);
        int colDiff = pawn[1].codeUnitAt(0) - move[1].codeUnitAt(0);

        if ((rowDiff).abs() > 1) {
          eatable = (int.parse(move[0]) + rowDiff ~/ 2).toString() +
              (int.parse(move[1]) + colDiff ~/ 2).toString();
          if (eatable.isNotEmpty) {
            eating.add(move);
            possibleEat.add({'moveTo': move, 'eat': eatable});
            print('eatable: $eatable');
          }
        }
      }

      if (eating.isNotEmpty) {
        eatingMoves[pawn] = eating;
      }
    }

    return eatingMoves;
  }

  Map<String, List<String>> nonRiskyMoves(
      Map<String, List<String>> possible, List<String> pawnEnemy) {
    Map<String, List<String>> nonRiskyMoves = {};

    for (String pawn in possible.keys) {
      activeTile = pawn;
      List<String> nextMoves = possible[pawn]!;
      Set<String> nonRisky = {};

      for (String move in nextMoves) {
        for (String enemy in pawnEnemy) {
          if (canBeEatenByPawn(move, tile: enemy) == '') {
            nonRisky.add(move);
          }
        }
      }

      if (nonRisky.isNotEmpty) {
        nonRiskyMoves[pawn] = nonRisky.toList();
      }
    }

    return nonRiskyMoves;
  }

  void aiPlayer() {
    if (turn == 'black') {
      Map<String, List<String>> possible =
          getAllNextPawnMoves(blackPawnsPositions, blackKingsPositions);
      Map<String, List<String>> eatingMoves = getEatingMoves(possible);

      if (eatingMoves.isNotEmpty) {
        possible = eatingMoves;
      }

      String pawn = possible.keys.toList()[Random().nextInt(possible.length)];
      String move = possible[pawn]![Random().nextInt(possible[pawn]!.length)];

      activeTile = pawn;

      if (blackPawnsPositions.contains(pawn)) {
        // print('pawn: $pawn, move: $move');
        movePawn(move);
      } else if (blackKingsPositions.contains(pawn)) {
        moveKing(move);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double squareSize = MediaQuery.of(context).size.width * 0.85 / columns;

    blackPawnsPositions = blackStartingPositions;
    whitePawnsPositions = whiteStartingPositions;

    changeTimer();
    scores();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.7,
                height: 100,
                decoration: const BoxDecoration(
                  color: kPieceDark,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: turn == 'white' ? 1 : kPlayerOpacity,
                      child: Image(
                        image: const AssetImage('assets/avatars/av1.png'),
                        width: squareSize,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: turn == 'white' ? 1 : kPlayerOpacity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder<int>(
                              stream: _whiteTimer.rawTime,
                              initialData: _whiteTimer.rawTime.value,
                              builder: (context, snapshot) {
                                final value = snapshot.data;
                                final displayTime =
                                    StopWatchTimer.getDisplayTime(value!,
                                        hours: true);
                                return Text(
                                  displayTime,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                );
                              }),
                          Text(
                            whiteScore.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image:
                              const AssetImage('assets/images/hourglass.png'),
                          width: squareSize / 3,
                        ),
                        const Text('Score'),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: turn == 'black' ? 1 : kPlayerOpacity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder<int>(
                              stream: _blackTimer.rawTime,
                              initialData: _blackTimer.rawTime.value,
                              builder: (context, snapshot) {
                                final value = snapshot.data;
                                final displayTime =
                                    StopWatchTimer.getDisplayTime(value!,
                                        hours: true);
                                return Text(
                                  displayTime,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                );
                              }),
                          Text(
                            blackScore.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: turn == 'black' ? 1 : kPlayerOpacity,
                      child: Image(
                        image: const AssetImage('assets/avatars/av2.png'),
                        width: squareSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: columns * squareSize + squareSize + 6,
                height: rows * squareSize + squareSize + 6,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: kPieceDark,
                  //   width: 20,
                  // ),
                  color: kPieceDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        label('A', squareSize),
                        label('B', squareSize),
                        label('C', squareSize),
                        label('D', squareSize),
                        label('E', squareSize),
                        label('F', squareSize),
                        label('G', squareSize),
                        label('H', squareSize),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            label('8', squareSize, row: false),
                            label('7', squareSize, row: false),
                            label('6', squareSize, row: false),
                            label('5', squareSize, row: false),
                            label('4', squareSize, row: false),
                            label('3', squareSize, row: false),
                            label('2', squareSize, row: false),
                            label('1', squareSize, row: false),
                          ],
                        ),
                        SizedBox(
                          width: columns * squareSize,
                          height: rows * squareSize,
                          child: GridView.builder(
                            itemCount: rows * columns,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                            ),
                            itemBuilder: (BuildContext itemContext, int index) {
                              final row = index ~/ columns;
                              final column = index % columns;
                              final isDark = (row + column) % 2 == 1;
                              final id = '$row$column';

                              return GestureDetector(
                                onTapDown: (TapDownDetails details) {
                                  final RenderBox? referenceBox =
                                      context.findRenderObject() as RenderBox?;
                                  if ((turn == 'white' &&
                                          whitePawnsPositions.contains(id)) ||
                                      (turn == 'black' &&
                                          blackPawnsPositions.contains(id))) {
                                    setState(() {
                                      activeTile = id;
                                      possibleMoves = getNextPawnMoves(id);
                                      possibleMoves =
                                          getRefinedNextMoves(possibleMoves);
                                    });
                                  } else if ((turn == 'white' &&
                                          whiteKingsPositions.contains(id) ||
                                      turn == 'black' &&
                                          blackKingsPositions.contains(id))) {
                                    setState(() {
                                      activeTile = id;
                                      possibleMoves = getNextKingMoves(id);
                                      print(
                                          'moving king: ${possibleEat.toString()}');
                                    });
                                  } else if (possibleMoves.contains(id)) {
                                    if (whiteKingsPositions
                                            .contains(activeTile) ||
                                        blackKingsPositions
                                            .contains(activeTile)) {
                                      moveKing(id);
                                      aiPlayer();
                                    } else {
                                      movePawn(id);
                                      aiPlayer();
                                    }
                                    setState(() {
                                      activeTile = '';
                                      possibleMoves = [];
                                    });
                                  } else {
                                    setState(() {
                                      activeTile = '';
                                      possibleMoves = [];
                                    });
                                  }

                                  checkIfGameWon(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: possibleMoves.contains(id)
                                        ? kWoodenBrown
                                        : isDark
                                            ? kBoardDark
                                            : kBoardLight,
                                    border: activeTile == id
                                        ? Border.all(
                                            color: Colors.redAccent,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: whiteStartingPositions
                                                  .contains(id) ||
                                              whiteKingsPositions.contains(id)
                                          ? Pawn(
                                              width: squareSize,
                                              height: squareSize,
                                              color: kPieceLight,
                                              isKing: whiteKingsPositions
                                                  .contains(id),
                                            )
                                          : blackStartingPositions
                                                      .contains(id) ||
                                                  blackKingsPositions
                                                      .contains(id)
                                              ? Pawn(
                                                  width: squareSize,
                                                  height: squareSize,
                                                  color: kPieceDark,
                                                  isKing: blackKingsPositions
                                                      .contains(id),
                                                )
                                              : possibleMoves.contains(id) &&
                                                      checkIfKing(id, turn) &&
                                                      !blackKingsPositions
                                                          .contains(
                                                              activeTile) &&
                                                      !whiteKingsPositions
                                                          .contains(activeTile)
                                                  ? Center(
                                                      child: Image(
                                                        image: const AssetImage(
                                                            'assets/images/crown.png'),
                                                        width: squareSize * .6,
                                                        height: squareSize * .6,
                                                      ),
                                                    )
                                                  : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Column(
                          children: [
                            label('0', squareSize, row: false),
                            label('1', squareSize, row: false),
                            label('2', squareSize, row: false),
                            label('3', squareSize, row: false),
                            label('4', squareSize, row: false),
                            label('5', squareSize, row: false),
                            label('6', squareSize, row: false),
                            label('7', squareSize, row: false),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        label('0', squareSize),
                        label('1', squareSize),
                        label('2', squareSize),
                        label('3', squareSize),
                        label('4', squareSize),
                        label('5', squareSize),
                        label('6', squareSize),
                        label('7', squareSize),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: kPieceDark,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          undoMove();
                        },
                        child: _bottomButton(Icons.undo, 'Undo')),
                    InkWell(
                        onTap: () {},
                        child: _bottomButton(Icons.handshake_outlined, 'Draw')),
                    InkWell(
                        onTap: () {},
                        child: _bottomButton(Icons.cancel_outlined, 'Quit')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _whiteTimer.dispose();
  }
}

Widget _bottomButton(IconData icon, String text) {
  return Column(
    children: [
      Icon(
        icon,
        color: Colors.white,
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}

Future customDialog(BuildContext context, String status) async {
  Size size = MediaQuery.of(context).size;
  return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Center(
            child: Container(
              width: size.width * .9,
              height: size.height * .5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: kBoardDark,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'You have $status',
                        style: const TextStyle(
                          color: kBoardLight,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Widget label(String text, double squareSize, {bool row = true}) {
  return Container(
    width: row ? squareSize : null,
    height: row ? null : squareSize,
    padding: const EdgeInsets.all(3),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: kPieceLight,
          fontSize: 11,
        ),
      ),
    ),
  );
}
