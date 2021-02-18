import 'package:math_fast/data/game/model.dart';

class GamesRepository {
  Map<String, GameModel> games = {};

  GamesRepository();

  GameModel getGame(String gameCode) {
    return games[gameCode];
  }

  GameModel upsertGame(GameModel game) {
    games[game.gameCode] = game;

    return game;
  }

  Map<String, GameModel> insertGame(GameModel game) {
    upsertGame(game);
    return games;
  }

  Map<String, GameModel> deleteGame(GameModel game) {
    games.remove(game.gameCode);

    return games;
  }
}
