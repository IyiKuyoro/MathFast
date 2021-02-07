import 'package:flutter/material.dart';
import 'package:math_fast/ui/pages/game_start_page.dart';

Widget gameRouter(List uriPathSegments) {
  if (uriPathSegments.length == 2) {
    String gameCode = uriPathSegments.first;
    String page = uriPathSegments.last;

    switch (page) {
      case 'new':
        return GameStartPage(gameCode: gameCode);
      default:
    }
  }

  return null;
}
