import 'package:checkers/widgets/statistics_header.dart';
import 'package:checkers/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(kBackground),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.brown.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kBoardDark,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: kWoodenBrown,
                      weight: 60,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
                StatisticsHead(),
                SizedBox(width: 50),
              ],
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Image(
                          image: AssetImage('assets/avatars/av1.png'),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: kBoardLight,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              child: Column(children: [
                Row(
                  children: [
                    keyText('Played'),
                    keyText('Won'),
                    keyText('Win ratio'),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.red,
                    )
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget keyText(String text) {
  print('$text');
  return Container(
    child: Text(
      text,
      style: TextStyle(
        fontSize: 200,
        color: Colors.grey,
        backgroundColor: Colors.green,
      ),
    ),
  );
}
