import 'package:checkers/utils/constants.dart';
import 'package:flutter/material.dart';

ButtonStyle buttonStyle1 = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
  minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: kWoodenBrown,
        width: 2,
      ),
    ),
  ),
);

ButtonStyle buttonStyle2 = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
  minimumSize: MaterialStateProperty.all<Size>(const Size(300, 70)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: kWoodenBrown,
        width: 4,
      ),
    ),
  ),
);
