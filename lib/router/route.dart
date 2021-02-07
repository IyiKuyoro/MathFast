import 'package:flutter/material.dart';
import 'package:math_fast/router/game_router.dart';
import 'package:math_fast/ui/pages/home_page.dart';

Route<dynamic> onGeneratedRoute(RouteSettings routeSettings) {
  Uri uri = Uri.parse(routeSettings.name);
  List uriPathSegments = uri.pathSegments;
  Widget page;

  if (uri.pathSegments.length >= 1) {
    var segment = uriPathSegments.first;
    List childSegments = uriPathSegments.sublist(1);

    switch (segment) {
      case 'games':
        page = gameRouter(childSegments);
        break;
      default:
    }
  }

  if (page == null) {
    page =  HomePage();
  }
  return MaterialPageRoute(
    builder: (context) => page,
  );
}
