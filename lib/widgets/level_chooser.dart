import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LevelChooser extends StatefulWidget {
  final int level;

  const LevelChooser({
    Key? key,
    this.level = Level.beginner,
  }) : super(key: key);

  @override
  State<LevelChooser> createState() => _LevelChooserState();
}

class _LevelChooserState extends State<LevelChooser> {
  var isSelected = List.filled(Level.names.length, false);

  @override
  Widget build(BuildContext context) {
    if (!isSelected.contains(true)) isSelected[widget.level] = true;

    Size size = MediaQuery.of(context).size;
    return ToggleButtons(
      constraints: BoxConstraints(minHeight: 36.0),
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          bool selected = isSelected[index];
          isSelected = List.filled(Level.names.length, false);
          isSelected[index] = !selected;
        });
      },
      children: [
        for (String name in Level.names) button(name, size, Level.names.indexOf(name)),
      ],
    );
  }

  Widget button(String type, Size size, int index) {
    return AnimatedOpacity(
      opacity: isSelected[index] ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: size.width / Level.names.length - 4,
        height: 50,
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSelected[index] ? 14 : 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}