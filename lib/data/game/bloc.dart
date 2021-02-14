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
          state.startGame();
          yield state;
          break;
        case StopGameEvent:
          state.endGame();
          yield state;
          break;
        case PauseGameEvent:
          state.pauseGame();
          yield state;
          break;
        case ChangeGameDuration:
          ChangeGameDuration changeGameDurationEvent =
              event as ChangeGameDuration;
          state.changeDuration(changeGameDurationEvent.newDuration);
          yield state;
          break;
        case ChangeGameDifficulty:
          ChangeGameDifficulty changeGameDifficultyEvent =
              event as ChangeGameDifficulty;
          state.changeDifficuty(changeGameDifficultyEvent.newDifficulty);
          yield state;
          break;
        default:
      }
    } on GameException catch (error) {
      state.addError(event.errorKey, error.message);
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
    switch (event.runtimeType) {
      case CreateGameEvent:
        CreateGameEvent createGameEvent = event as CreateGameEvent;
        state[createGameEvent.game.gameCode] = createGameEvent.game;
        yield state;
        break;
      case DeleteGameEvent:
        DeleteGameEvent removeGameEvent = event as DeleteGameEvent;
        Game gameToBeRemoved = removeGameEvent.game;
        state.remove(gameToBeRemoved.gameCode);
        yield state;
        break;
      default:
    }
  }
}
