import 'package:flutter/material.dart';

class ChessBoardPainter extends CustomPainter {
  final darkTileColor = Colors.brown[700];
  final lightTileColor = Colors.brown[100];

  @override
  void paint(Canvas canvas, Size size) {
    final squareSize = size.width / 8;
    final paint = Paint();

    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        paint.color = ((i + j) % 2 == 0 ? lightTileColor : darkTileColor)!;
        canvas.drawRect(
          Rect.fromLTWH(i * squareSize, j * squareSize, squareSize, squareSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  late Offset _tapPosition;

  void _handleTapDown(TapDownDetails details, double width) {
    setState(() {
      _tapPosition = details.localPosition;
    });
    final squareSize = width / 8;
    final int column = (_tapPosition.dx / squareSize).floor();
    final int row = (_tapPosition.dy / squareSize).floor();
    print('Tapped on tile $column, $row');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    return GestureDetector(
      // onTapDown: _handleTapDown(width),
      child: CustomPaint(
        size: Size(width, width),
        painter: ChessBoardPainter(),
      ),
    );
  }
}
