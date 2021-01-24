import 'package:flutter/material.dart';
import 'package:math_fast/utils/helper_functions.dart';

enum GameState {
  notStarted,
  started,
  ended,
}

@immutable
class Game {
  final String gameCode;
  final GameState _gameState;
  final bool _isPaused;

  /// Create a new game instance in a not started state
  Game.newGame()
      : _gameState = GameState.notStarted,
        _isPaused = false,
        gameCode = genCode(prefix: 'GAM');

  /// Returns the current game state
  GameState get gameState => _gameState;

  bool get isPaused => _isPaused;
}
