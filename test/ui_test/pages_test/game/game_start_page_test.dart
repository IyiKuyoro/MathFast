import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/ui/pages/game/game_start_page.dart';

import '../../../config.dart';

main() {
  group('GameStartPage', () {
    testWidgets('should render form', (WidgetTester tester) async {
      Game game = Game.newGame();
      HashMap<String, Game> gamesMap = HashMap<String, Game>();
      gamesMap[game.gameCode] = game;

      GameStartPage gameStartPage = GameStartPage(gameCode: game.gameCode);

      await tester.pumpWidget(testWidgetPageWrapper(
        gameStartPage,
        GamesBloc(gamesMap),
      ));

      expect(find.text('Duration (Secs)'), findsOneWidget);
      expect(find.text('Difficulty'), findsOneWidget);
    });
  });
}
