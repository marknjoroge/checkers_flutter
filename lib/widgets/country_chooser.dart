import 'package:checkers/utils/constants.dart';
import 'package:flutter/material.dart';

class CountryChooser extends StatefulWidget {
  final int type;

  const CountryChooser({
    Key? key,
    this.type = GameType.american,
  }) : super(key: key);

  @override
  State<CountryChooser> createState() => _CountryChooserState();
}

class _CountryChooserState extends State<CountryChooser> {
  var isSelected = List.filled(GameType.names.length, false);

  @override
  Widget build(BuildContext context) {
    if (!isSelected.contains(true)) isSelected[widget.type] = true;

    Size size = MediaQuery.of(context).size;
    return ToggleButtons(
      constraints: const BoxConstraints(minHeight: 36.0),
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          bool selected = isSelected[index];
          isSelected = List.filled(GameType.names.length, false);
          isSelected[index] = !selected;
        });
      },
      children: [
        for (String name in GameType.names)
          button(name, size, GameType.names.indexOf(name)),
      ],
    );
  }

  Widget button(String type, Size size, int index) {
    return AnimatedOpacity(
      opacity: isSelected[index] ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: (size.width / GameType.names.length - 4) - (30/GameType.names.length),
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/flags/$type.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSelected[index] ? 14 : 10,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
