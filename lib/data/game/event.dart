import 'package:flutter/material.dart';
import 'package:math_fast/data/event.dart';
import 'package:math_fast/data/game/model.dart';

abstract class GameEvent extends Event {
  final Key errorKey;
  final GameModel game;

  GameEvent({@required this.errorKey, @required this.game});
}

/// Start game event
@immutable
class StartGameEvent extends GameEvent {
  StartGameEvent({
    @required Key errorKey,
    @required GameModel game,
  }) : super(errorKey: errorKey, game: game);
}

/// Stop game event
@immutable
class StopGameEvent extends GameEvent {
  StopGameEvent({
    @required Key errorKey,
    @required GameModel game,
  }) : super(errorKey: errorKey, game: game);
}

/// Pause game event
@immutable
class PauseGameEvent extends GameEvent {
  PauseGameEvent({
    @required Key errorKey,
    @required GameModel game,
  }) : super(errorKey: errorKey, game: game);
}

/// Modify game duration
@immutable
class ChangeGameDuration extends GameEvent {
  final int newDuration;

  ChangeGameDuration({
    @required this.newDuration,
    @required Key errorKey,
    @required GameModel game,
  }) : super(errorKey: errorKey, game: game);
}

/// Modify game difficulty
@immutable
class ChangeGameDifficulty extends GameEvent {
  final GameDifficulty newDifficulty;

  ChangeGameDifficulty({
    @required this.newDifficulty,
    @required Key errorKey,
    @required GameModel game,
  }) : super(errorKey: errorKey, game: game);
}

abstract class GamesEvent extends Event {}

/// Create a new game and add to state
@immutable
class InsertGameEvent extends GamesEvent {
  final Game game;

  CreateGameEvent() : this.game = Game.newGame();
}

/// Remove a game from state
@immutable
class DeleteGameEvent extends GamesEvent {
  final Game game;

  DeleteGameEvent({@required this.game});
}
