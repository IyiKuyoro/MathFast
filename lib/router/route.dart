import 'package:flutter/material.dart';
import 'package:math_fast/router/game_router.dart';
import 'package:math_fast/ui/components/page_container.dart';
import 'package:math_fast/ui/pages/home_page.dart';

Route<dynamic> onGeneratedRoute(RouteSettings routeSettings) {
  Uri uri = Uri.parse(routeSettings.name);
  List uriPathSegments = uri.pathSegments;

  if (uri.pathSegments.length >= 1) {
    var segment = uriPathSegments.first;
    List childSegments = uriPathSegments.sublist(1);

    switch (segment) {
      case 'games':
        return gameRouter(childSegments);
        break;
      default:
    }
  }

  return MaterialPageRoute(
    builder: (context) => PageContainer(child: HomePage()),
  );
}
