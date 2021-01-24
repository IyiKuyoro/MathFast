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
