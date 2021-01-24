import 'package:flutter/material.dart';
import 'package:math_fast/data/game/model.dart';

abstract class GameException implements Exception {
  final Game game;
  final String message;

  /// Creates a game exception
  GameException({
    @required this.game,
    this.message = "A game exception has occured",
  });
}

/// Used to signify that a requested game does not exist
class GameDoesNotExist extends GameException {
  GameDoesNotExist()
    : super(
          game: null,
          message: 'Game does not exisit',
        );
}

/// Used to signify that a game has ended and cannot be futher modified.
class EndedGameException extends GameException {
  /// Creates an ended game exception.
  EndedGameException({@required Game game})
      : super(
          game: game,
          message: 'Game with code ${game.gameCode} has ended',
        );
}


/// Used to signify that a game has started
/// and some operations can no longer be performed.
class GameAlreadyStartedException extends GameException {
  /// Creates a game already started exception
  GameAlreadyStartedException({@required Game game})
      : super(
          game: game,
          message: 'Game with code ${game.gameCode} has already started.',
        );
}
