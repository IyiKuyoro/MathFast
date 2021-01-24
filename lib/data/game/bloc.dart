import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:math_fast/data/bloc_mixin.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';

class GameBloc extends Bloc<GameEvent, Game> with BlocMixin<GameEvent, Game> {
  /// Creates a game state from an existing game
  GameBloc(Game initialState) : super(initialState);

  /// Handles GameEvent to modify Game State
  @override
  Stream<Game> mapEventToState(GameEvent event) async* {
    try {
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
        default:
      }
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
