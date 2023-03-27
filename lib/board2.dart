import 'package:flutter/material.dart';

import 'pawn.dart';

class ChessBoard extends StatefulWidget {
  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  final int rows = 8;
  final int columns = 8;

  String turn = 'white';

  var activeTile = '';

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

  List<String> blackPositions = [];
  List<String> whitePositions = [];

  List<String> possibleMoves = [];

  List<String> getRefinedNextMoves(List<String> moves) {
    List<String> refinedMoves = [];

    for (String move in moves) {
      if (!blackPositions.contains(move) && !whitePositions.contains(move)) {
        refinedMoves.add(move);
      }
    }

    return refinedMoves;
  }

  List<String> getDiagonalsFromPoint(String position) {
    List<String> diagonals = [];

    int row = int.parse(position[0]);
    int col = int.parse(position[1]);

    int rowDir = 1;
    int colDir = 1;

    for (int i = 0; i < 4; i++) {
      int nextRow = row + rowDir;
      int nextCol = col + colDir;

      if (nextRow >= 1 && nextRow <= 8 && nextCol >= 1 && nextCol <= 8) {
        String nextPosition = '${nextRow}${nextCol}';
        diagonals.add(nextPosition);
      }

      if (i == 1) {
        rowDir = -1;
      } else if (i == 2) {
        colDir = -1;
      } else if (i == 3) {
        rowDir = 1;
      }
    }

    return diagonals;
  }

  List<String> canBeEatenByPawn(String position) {
    List<String> diagonals = getDiagonalsFromPoint(position);

    List<String> canBeEaten = [];

    for (String diagonal in diagonals) {
      if (turn == 'white') {
        if (blackPositions.contains(diagonal)) {
          canBeEaten.add(diagonal);
        }
      } else {
        if (whitePositions.contains(diagonal)) {
          canBeEaten.add(diagonal);
        }
      }
    }

    return canBeEaten;
  }

  List<String> getNextMoves(String currentPosition) {
    // Convert the current position to row and column indices
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
        if (nextRow >= 1 && nextRow <= 8 && nextCol >= 1 && nextCol <= 8) {
          // Add the next move to the list
          String nextPosition = '${nextRow}${nextCol}';
          nextMoves.add(nextPosition);
        }
      }
    }

    // check if pawn can eat another pawn
    for (String move in nextMoves) {
      if (turn == 'white' && blackPositions.contains(move)) {
        
      } else if (whitePositions.contains(move) && turn == 'black') {
         
      }
    }

    // Return the list of next moves
    return nextMoves;
  }

  void movePawn(String position) {
    if (turn == 'white') {
      whitePositions.remove(activeTile);
      whitePositions.add(position);
      turn = 'black';
    } else {
      blackPositions.remove(activeTile);
      blackPositions.add(position);
      turn = 'white';
    }

    activeTile = '';
    possibleMoves = [];
  }

  @override
  Widget build(BuildContext context) {
    double squareSize = MediaQuery.of(context).size.width * 0.9 / columns;

    blackPositions = blackStartingPositions;
    whitePositions = whiteStartingPositions;

    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: columns * squareSize,
            height: rows * squareSize,
            child: GridView.builder(
              itemCount: rows * columns,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    if ((turn == 'white' && whitePositions.contains(id)) || (turn == 'black' && blackPositions.contains(id))) {
                      setState(() {
                        activeTile = id;
                        possibleMoves = getNextMoves(id);
                        possibleMoves = getRefinedNextMoves(possibleMoves);
                        // print(possibleMoves.toString());
                        print('diagonals: ${getDiagonalsFromPoint(id).toString()}');
                      });
                    } else if (possibleMoves.contains(id)) {
                      movePawn(id);
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
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: possibleMoves.contains(id)
                          ? Colors.lightBlue
                          : isDark
                              ? Colors.brown[700]
                              : Colors.brown[100],
                      border: activeTile == id
                          ? Border.all(
                              color: Colors.redAccent,
                              width: 2.0,
                            )
                          : null,
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        child: whiteStartingPositions.contains(id)
                            ? Pawn(
                                width: squareSize,
                                height: squareSize,
                                color: Colors.white,
                              )
                            : blackStartingPositions.contains(id)
                                ? Pawn(
                                    width: squareSize,
                                    height: squareSize,
                                    color: Colors.black,
                                  ) as Widget
                                : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: columns * squareSize,
            height: rows * squareSize,
          ),
        )
      ],
    );
  }
}
