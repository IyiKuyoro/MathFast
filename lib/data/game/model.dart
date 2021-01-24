import 'package:math_fast/utils/exceptions/game_exceptions.dart';
import 'package:math_fast/utils/helper_functions.dart';

enum GameState {
  notStarted,
  started,
  ended,
}

class Game {
  String gameCode;
  GameState _gameState;
  bool _isPaused;

  /// Create a new game instance in a not started state
  Game.newGame()
      : _gameState = GameState.notStarted,
        _isPaused = false,
        gameCode = genCode(prefix: 'GAM');

  /// Returns the current game state
  GameState get gameState => _gameState;

  /// Set the game state
  set gameState(GameState value) {
    if (!canChangeState) throw EndedGameException(game: this);
    if (_gameState == GameState.started && value == GameState.notStarted)
      throw GameAlreadyStartedException(game: this);

    _gameState = value;
  }

  /// Return paused game state
  bool get isPaused => _isPaused;

  /// Can the current game be paused of not
  bool get canPause => _gameState == GameState.started;

  /// Can the current game state be changed
  bool get canChangeState => _gameState != GameState.ended;

  /// Pause a started game
  bool pauseGame() {
    if (!canPause) return false;

    _isPaused = true;
    return _isPaused;
  }
}
