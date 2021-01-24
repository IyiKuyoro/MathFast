import 'dart:async';

import 'package:math_fast/data/bloc.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/utils/exceptions/game_exceptions.dart';

class GameBloc implements Bloc {
  Game _game;
  Map<String, Game> _games;
  final _gameController = StreamController<Game>();
  final _gamesController = StreamController<Map<String, Game>>();

  /// Get the game stream
  Stream<Game> get gameStream => _gameController.stream.asBroadcastStream();

  /// Get the list og games stream
  Stream<Map<String, Game>> get gamesStream =>
      _gamesController.stream.asBroadcastStream();

  /// Change the selected game by [gameCode]
  Game selectGame(String gameCode) {
    Game game = _games[gameCode];

    if (game == null) throw GameDoesNotExist();

    _game = game;
    _gameController.sink.add(game);
    return _game;
  }

  /// Add a new [game] to the games
  void addGame(Game game) {
    _games[game.gameCode] = game;
    _gamesController.sink.add(_games);
  }

  @override
  void dispose() {
    _gameController.close();
    _gamesController.close();
  }
}
