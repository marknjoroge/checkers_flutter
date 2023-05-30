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
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: const Icon(
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
                const StatisticsHead(),
                const SizedBox(width: 50),
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
                const SizedBox(width: 20),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 29,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 10),
                  child: Text(
                    'Statistics',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      // backgroundColor: kBoardDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          keyText(''),
                          keyText('Played'),
                          keyText('Won'),
                          keyText('Win ratio'),
                          keyText('Best time'),
                        ],
                      ),
                      TableRow(
                        children: [
                          keyText('vs Human (online)'),
                          valueText('10'),
                          valueText('5'),
                          valueText('50%'),
                          valueText('1:30'),
                        ],
                      ),
                      TableRow(
                        children: [
                          keyText('vs Human (offline)'),
                          valueText('10'),
                          valueText('5'),
                          valueText('50%'),
                          valueText('1:30'),
                        ],
                      ),
                      TableRow(
                        children: [
                          keyText('vs AI'),
                          valueText('10'),
                          valueText('5'),
                          valueText('50%'),
                          valueText('1:30'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget keyText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
  );
}

Widget valueText(String text) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        color: kBoardDark,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
