import 'package:flutter/material.dart';
import 'package:math_fast/ui/components/page_container.dart';
import 'package:math_fast/ui/pages/game_page.dart';

MaterialPageRoute gameRouter(List uriPathSegments) {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      if (uriPathSegments.length == 2) {
        String gameCode = uriPathSegments.first;
        String page = uriPathSegments.last;

        switch (page) {
          case 'new':
            return GameStartPage(gameCode: gameCode);
            break;
          default:
        }
      }

      return PageContainer(child: Text('Unknown'));
    },
  );
}
