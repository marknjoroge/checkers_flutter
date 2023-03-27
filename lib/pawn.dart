import 'package:flutter/material.dart';

class Pawn extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const Pawn({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.8,
      height: height * 0.8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
