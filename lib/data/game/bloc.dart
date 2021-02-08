import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:math_fast/data/bloc_mixin.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/utils/exceptions/game_exceptions.dart';

class GameBloc extends Bloc<GameEvent, Game> with BlocMixin<GameEvent, Game> {
  /// Creates a game state from an existing game
  GameBloc(Game initialState) : super(initialState);

  /// Handles GameEvent to modify Game State
  @override
  Stream<Game> mapEventToState(GameEvent event) async* {
    try {
      state.clearError(event.errorKey);
      switch (event.runtimeType) {
        case StartGameEvent:
          state.gameState = GameState.started;
          break;
        case StopGameEvent:
          state.gameState = GameState.ended;
          break;
        case PauseGameEvent:
          state.pauseGame();
          break;
        case ChangeGameDuration:
          ChangeGameDuration changeGameDurationEvent =
              event as ChangeGameDuration;
          state.changeDuration(changeGameDurationEvent.newDuration);
          break;
        case ChangeGameDifficulty:
          ChangeGameDifficulty changeGameDifficultyEvent =
              event as ChangeGameDifficulty;
          state.changeDifficuty(changeGameDifficultyEvent.newDifficulty);
          break;
        default:
      }
    } on EndedGameException catch (_) {
      // TODO: Handle error with notification to screen
    } on GameAlreadyStartedException catch (_) {
      // TODO: Handle error with notification to screen
    } on GameSettingsException catch (error) {
      state.addError(event.errorKey, error.message);
    } finally {
      yield state;
    }
  }
}

class GamesBloc extends Bloc<GamesEvent, HashMap<String, Game>>
    with BlocMixin<GamesEvent, HashMap<String, Game>> {
  /// Creates the games state from exhisiting games has map
  GamesBloc(HashMap<String, Game> initialState) : super(initialState);

  /// Handles GamesEvent to modify the Games state
  @override
  Stream<HashMap<String, Game>> mapEventToState(GamesEvent event) async* {
    try {
      switch (event.runtimeType) {
        case CreateGameEvent:
          CreateGameEvent createGameEvent = event as CreateGameEvent;
          state[createGameEvent.game.gameCode] = createGameEvent.game;
          break;
        case DeleteGameEvent:
          DeleteGameEvent removeGameEvent = event as DeleteGameEvent;
          Game gameToBeRemoved = removeGameEvent.game;
          state.remove(gameToBeRemoved.gameCode);
          break;
        default:
      }
    } finally {
      yield state;
    }
  }
}
