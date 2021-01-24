import 'package:bloc/bloc.dart';
import 'package:math_fast/data/bloc_mixin.dart';
import 'package:math_fast/data/game/model.dart';

enum GameEvent {
  start,
  stop,
  pause,
}

class GameBloc extends Bloc<GameEvent, Game> with BlocMixin<GameEvent, Game> {
  // Creates a game state from an existing game
  GameBloc({Game game}) : super(game);

  /// Creates the initial Game state for a new game
  GameBloc.newGame() : super(Game.newGame());

  /// Handles GameEvent to modify Game State
  @override
  Stream<Game> mapEventToState(GameEvent event) async* {
    try {
      switch (event) {
        case GameEvent.start:
          state.gameState = GameState.started;
          break;
        case GameEvent.stop:
          state.gameState = GameState.ended;
          break;
        case GameEvent.pause:
          state.pauseGame();
          break;
        default:
      }
    } finally {
      yield state;
    }
  }
}
