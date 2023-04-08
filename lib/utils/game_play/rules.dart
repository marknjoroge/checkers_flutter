class AmericanCheckers {
  List<String> normalPawnMoves(
      List<String> possibleMoves, String position, String color) {
    List<String> americanCheckersRules = [];
    List<String> eatMoves = [];

    int side = 0;
    if (color == 'white') {
      side = 1;
    } else {
      side = -1;
    }
    for (int i = 0; i < possibleMoves.length; i++) {
      int theSide = int.parse(position[0]) - int.parse(possibleMoves[i][0]);
      print(theSide);
      print(side);
      if ((theSide > 0 && side > 0) || (theSide < 0 && side < 0)) {
        if (theSide > 1 || theSide < -1) {
          eatMoves.add(possibleMoves[i]);
        }
        americanCheckersRules.add(possibleMoves[i]);
      }
    }

    if (eatMoves.isNotEmpty) {
      return eatMoves;
    }

    return americanCheckersRules;
  }

  List<String> kingPawnMoves(
      List<String> possibleMoves, String position, String color) {
    List<String> americanCheckersRules = [];

    int side = 0;
    if (color == 'white') {
      side = 1;
    } else {
      side = -1;
    }
    for (int i = 0; i < possibleMoves.length; i++) {
      if (((position[0] as int) - (possibleMoves[i][0] as int)) == side ||
          ((position[0] as int) - (possibleMoves[i][0] as int)) == -side) {
        americanCheckersRules.add(possibleMoves[i]);
      }
    }
    return americanCheckersRules;
  }
}

class InternationalCheckers {
  List<String> normalPawnMoves(
      List<String> possibleMoves, String position, String color) {
    List<String> internationalCheckersRules = [];

    int side = 0;
    if (color == 'white') {
      side = 1;
    } else {
      side = -1;
    }
    for (int i = 0; i < possibleMoves.length; i++) {
      int theSide = int.parse(position[0]) - int.parse(possibleMoves[i][0]);
      print(theSide);
      if (theSide == side) {
        internationalCheckersRules.add(possibleMoves[i]);
      }
    }
    return internationalCheckersRules;
  }

  List<String> kingPawnMoves(
      List<String> possibleMoves, String position, String color) {
    List<String> internationalCheckersRules = [];

    int side = 0;
    if (color == 'white') {
      side = 1;
    } else {
      side = -1;
    }
    for (int i = 0; i < possibleMoves.length; i++) {
      if (((position[0] as int) - (possibleMoves[i][0] as int)) == side ||
          ((position[0] as int) - (possibleMoves[i][0] as int)) == -side) {
        internationalCheckersRules.add(possibleMoves[i]);
      }
    }
    return internationalCheckersRules;
  }
}
