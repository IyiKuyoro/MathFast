import 'package:flutter/material.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/routes/root_route.dart';

class GameRoutePath extends RootRoutePath {
  final Game game;

  /// Create path for game start screen
  GameRoutePath({@required this.game}) : super();

  /// Create unknown game route
  GameRoutePath.unknown()
      : this.game = null,
        super.unknown();

  /// Is the current game being played or not
  bool get isPlaying => !isUnknown && game.gameState == GameState.started;

  /// Is the current game in a not started state
  bool get notStarted => !isUnknown && game.gameState == GameState.notStarted;

  // is the current game in an ended state
  bool get isEnded => !isUnknown && game.gameState == GameState.ended;
}
