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
      if (state.errorMap.containsKey(event.errorKey)) {
        yield state.removeError(event.errorKey);
      }
      switch (event.runtimeType) {
        case StartGameEvent:
          yield state.startGame();
          break;
        case StopGameEvent:
          yield state.endGame();
          break;
        case PauseGameEvent:
          yield state.toggleGamePause();
          break;
        case ChangeGameDuration:
          ChangeGameDuration changeGameDurationEvent =
              event as ChangeGameDuration;
          yield state.changeDuration(changeGameDurationEvent.newDuration);
          break;
        case ChangeGameDifficulty:
          ChangeGameDifficulty changeGameDifficultyEvent =
              event as ChangeGameDifficulty;
          yield state.changeDifficuty(changeGameDifficultyEvent.newDifficulty);
          break;
        default:
      }
    } on GameException catch (error) {
      yield state.addError(event.errorKey, error.message);
    } on GameSettingsException catch (error) {
      yield state.addError(event.errorKey, error.message);
    }
  }
}

class GamesBloc extends Bloc<GamesEvent, Games>
    with BlocMixin<GamesEvent, Games> {
  /// Creates the games state from exhisiting games has map
  GamesBloc(Games initialState) : super(initialState);

  /// Handles GamesEvent to modify the Games state
  @override
  Stream<Games> mapEventToState(GamesEvent event) async* {
    switch (event.runtimeType) {
      case CreateGameEvent:
        CreateGameEvent createGameEvent = event as CreateGameEvent;
        yield state.upsertGame(createGameEvent.game);
        break;
      case DeleteGameEvent:
        DeleteGameEvent removeGameEvent = event as DeleteGameEvent;
        Game gameToBeRemoved = removeGameEvent.game;
        yield state.removeGame(gameToBeRemoved.gameCode);
        break;
      default:
    }
  }
}
