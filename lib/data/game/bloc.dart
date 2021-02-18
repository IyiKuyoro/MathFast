import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_fast/data/bloc_mixin.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart' as GameModel;
import 'package:math_fast/data/game/resource.dart';
import 'package:math_fast/data/game/state.dart';
import 'package:math_fast/utils/exceptions/game_exceptions.dart';

class GameBloc extends Bloc<GameEvent, GameState>
    with BlocMixin<GameEvent, GameState> {
  final GamesRepository gamesRepository;

  /// Creates a game state from an existing game
  GameBloc({
    @required this.gamesRepository,
  }) : super(GameInitialState());

  /// Handles GameEvent to modify Game State
  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    try {
      if (event is StartGameEvent) {
        yield* _mapStartGameEventToState(event);
      } else if (event is StopGameEvent) {
        yield* _mapStopGameEventToState(event);
      } else if (event is PauseGameEvent) {
        yield* _mapPauseGameEventToState(event);
      } else if (event is ChangeGameDuration) {
        yield* _mapChangeGameDurationToState(event);
      } else if (event is ChangeGameDifficulty) {
        yield* _mapChangeGameDifficultyToState(event);
      }
    } on GameException catch (_) {
      yield GameErroredState(state.game);
    } on GameSettingsException catch (_) {
      yield GameErroredState(state.game);
    }
  }

  Stream<GameState> _mapStartGameEventToState(StartGameEvent event) async* {
    GameModel.GameModel game = event.game;
    game = gamesRepository.upsertGame(game.startGame());

    yield GameSetupState(game);
  }

  Stream<GameState> _mapStopGameEventToState(StopGameEvent event) async* {
    GameModel.GameModel game = event.game;
    game = gamesRepository.upsertGame(game.endGame());

    yield GameEndedState(game);
  }

  Stream<GameState> _mapPauseGameEventToState(PauseGameEvent event) async* {
    GameModel.GameModel game = event.game;
    game = gamesRepository.upsertGame(game.toggleGamePause());

    yield GamePausedState(game);
  }

  Stream<GameState> _mapChangeGameDurationToState(
    ChangeGameDuration event,
  ) async* {
    GameModel.GameModel game = event.game;
    game = gamesRepository.upsertGame(game.changeDuration(event.newDuration));

    yield GamePlayingState(game);
  }

  Stream<GameState> _mapChangeGameDifficultyToState(
    ChangeGameDifficulty event,
  ) async* {
    GameModel.GameModel game = event.game;
    game =
        gamesRepository.upsertGame(game.changeDifficuty(event.newDifficulty));

    yield GamePlayingState(game);
  }
}

class GamesBloc extends Bloc<GamesEvent, GamesState>
    with BlocMixin<GamesEvent, GamesState> {
  final GamesRepository gamesRepository;

  /// Creates the games state from exhisiting games has map
  GamesBloc({
    @required this.gamesRepository,
  }) : super(GamesInitialState());

  /// Handles GamesEvent to modify the Games state
  @override
  Stream<GamesState> mapEventToState(GamesEvent event) async* {
    if (event is InsertGameEvent) {
      yield* _mapCreateGameEventToState(event);
    } else if (event is DeleteGameEvent) {
      yield* _mapDeleteGameEventToState(event);
    }
  }

  Stream<GamesState> _mapCreateGameEventToState(
    InsertGameEvent event,
  ) async* {
    Map<String, GameModel.GameModel> games = gamesRepository.insertGame(event.game);

    yield InsertedGameGamesState(games);
  }

  Stream<GamesState> _mapDeleteGameEventToState(
    DeleteGameEvent event,
  ) async* {
    Map<String, GameModel.GameModel> games = gamesRepository.deleteGame(event.game);

    yield InsertedGameGamesState(games);
  }
}
