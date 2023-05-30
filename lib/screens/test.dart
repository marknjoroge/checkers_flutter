import 'package:checkers/screens/home.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/texts.styles.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Dialog(
        child: Container(
          width: size.width * .9,
          // height: size.height * .5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            image: DecorationImage(image: AssetImage('')),
            color: kBoardDark,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'YOU WON!',
                    style: const TextStyle(
                      color: kBoardLight,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Time',
                        style: kHelperTextStyle,
                      ),
                      Text('00:00', style: kMainTextStyle),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Best Time', style: kHelperTextStyle),
                      Text('00:00', style: kMainTextStyle),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Score difference', style: kHelperTextStyle),
                      Text('02', style: kMainTextStyle),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Best Score Difference', style: kHelperTextStyle),
                      Text('05', style: kMainTextStyle),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWoodenBrown,
                        borderRadius: BorderRadius.circular(25),boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.replay_rounded,
                        color: kBoardLight,
                        size: 50,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Home()),
                          (r) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWoodenBrown,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.navigate_next_rounded,
                        color: kBoardLight,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
