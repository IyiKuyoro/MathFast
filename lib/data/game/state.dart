import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:math_fast/data/game/model.dart';

abstract class GameState extends Equatable {
  final GameModel game;

  const GameState({
    @required this.game,
  });

  @override
  List<Object> get props => [game];
}

class GameInitialState extends GameState {
  GameInitialState();
}

class GameLoadingState extends GameState {
  GameLoadingState(GameModel game) : super(game: game);
}

class GameSetupState extends GameState {
  GameSetupState(GameModel game) : super(game: game);
}

class GamePlayingState extends GameState {
  GamePlayingState(GameModel game) : super(game: game);
}

class GameErroredState extends GameState {
  GameErroredState(GameModel game) : super(game: game);
}

class GameEndedState extends GameState {
  GameEndedState(GameModel game) : super(game: game);
}

class GamePausedState extends GameState {
  GamePausedState(GameModel game) : super(game: game);
}

abstract class GamesState extends Equatable {
  final Map<String, GameModel> games;

  const GamesState({
    this.games: const {},
  });

  @override
  List<Object> get props => [games];
}

class GamesInitialState extends GamesState {
  GamesInitialState();
}

class InsertedGameGamesState extends GamesState {
  InsertedGameGamesState(Map<String, GameModel> games) : super(games: games);
}

class DeletedGameState extends GamesState {
  DeletedGameState(Map<String, GameModel> games) : super(games: games);
}
