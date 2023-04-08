import 'package:flutter/material.dart';

class CountryChooser extends StatefulWidget {
  const CountryChooser({super.key});

  @override
  State<CountryChooser> createState() => _CountryChooserState();
}

class _CountryChooserState extends State<CountryChooser> {
  var isSelected = <bool>[false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ToggleButtons(
      constraints: BoxConstraints(minHeight: 36.0),
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          bool selected = isSelected[index];
          isSelected = <bool>[false, false, false, false, false, false];
          isSelected[index] = !selected;
        });
      },
      children: [
        AnimatedOpacity(
          opacity: isSelected[0] ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 300),
          child: button('american', size),
        ),
        AnimatedOpacity(
          opacity: isSelected[1] ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 300),
          child: button('turkish', size),
        ),
        AnimatedOpacity(
          opacity: isSelected[2] ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 300),
          child: button('russian', size),
        ),
        AnimatedOpacity(
          opacity: isSelected[3] ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 300),
          child: button('czech', size),
        ),
        AnimatedOpacity(
          opacity: isSelected[4] ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 300),
          child: button('italian', size),
        ),
        AnimatedOpacity(
          opacity: isSelected[5] ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 300),
          child: button('international', size),
        ),
      ],
    );
  }
}

Widget button(String type, size) {
  return Container(
    width: size.width / 6.5,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage('assets/flags/$type.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Text(
        type,
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
