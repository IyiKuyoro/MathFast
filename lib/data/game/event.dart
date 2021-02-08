import 'package:flutter/material.dart';
import 'package:math_fast/data/event.dart';
import 'package:math_fast/data/game/model.dart';

abstract class GameEvent extends Event {
  final Key errorKey;

  GameEvent({@required this.errorKey});
}

/// Start game event
@immutable
class StartGameEvent extends GameEvent {
  StartGameEvent({@required errorKey}) : super(errorKey: errorKey);
}

/// Stop game event
@immutable
class StopGameEvent extends GameEvent {
  StopGameEvent({@required errorKey}) : super(errorKey: errorKey);
}

/// Pause game event
@immutable
class PauseGameEvent extends GameEvent {
  PauseGameEvent({@required errorKey}) : super(errorKey: errorKey);
}

/// Modify game duration
@immutable
class ChangeGameDuration extends GameEvent {
  final Game game;
  final int newDuration;

  ChangeGameDuration({
    @required this.game,
    @required this.newDuration,
    @required errorKey,
  }) : super(errorKey: errorKey);
}

/// Modify game difficulty
@immutable
class ChangeGameDifficulty extends GameEvent {
  final Game game;
  final GameDifficulty newDifficulty;

  ChangeGameDifficulty({
    @required this.game,
    @required this.newDifficulty,
    @required errorKey,
  }) : super(errorKey: errorKey);
}

abstract class GamesEvent extends Event {}

/// Create a new game and add to state
@immutable
class CreateGameEvent extends GamesEvent {
  final Game game;

  CreateGameEvent() : this.game = Game.newGame();
}

/// Remove a game from state
@immutable
class DeleteGameEvent extends GamesEvent {
  final Game game;

  DeleteGameEvent({@required this.game});
}
