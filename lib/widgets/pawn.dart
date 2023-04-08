import 'package:flutter/material.dart';

class Pawn extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final bool? isKing;

  const Pawn({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    this.isKing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.8,
      height: height * 0.8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-3, 5),
          ),
        ],
      ),
      child: isKing!
          ? Center(
              child: Image(
                image: const AssetImage('assets/images/crown.png'),
                width: width * .6,
                height: height * .6,
              ),
            )
          : null,
    );
  }
}
