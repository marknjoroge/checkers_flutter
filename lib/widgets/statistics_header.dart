import 'package:flutter/material.dart';

class StatisticsHead extends StatefulWidget {
  const StatisticsHead({super.key});

  @override
  State<StatisticsHead> createState() => _StatisticsHeadState();
}

class _StatisticsHeadState extends State<StatisticsHead> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage("assets/images/coins.png"),
            width: 25,
            height: 25,
          ),
        ),
        Text(
          '350',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 20),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(
              image: AssetImage("assets/images/flash.png"),
              width: 25,
              height: 25),
        ),
        Text(
          '350',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
