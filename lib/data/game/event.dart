import 'package:flutter/material.dart';
import 'package:math_fast/data/event.dart';
import 'package:math_fast/data/game/model.dart';

abstract class GameEvent extends Event {}

/// Start game event
@immutable
class StartGameEvent extends GameEvent {}

/// Stop game event
@immutable
class StopGameEvent extends GameEvent {}

/// Pause game event
@immutable
class PauseGameEvent extends GameEvent {}

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
