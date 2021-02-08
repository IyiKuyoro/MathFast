import 'package:math_fast/data/model.dart';
import 'package:math_fast/utils/exceptions/game_exceptions.dart';
import 'package:math_fast/utils/helper_functions.dart';

enum GameState {
  notStarted,
  started,
  ended,
}

enum GameDifficulty {
  easy,
  medium,
  hard,
}

class GameSettings {
  GameDifficulty difficulty;
  int _duration;

  /// Create new game settings
  GameSettings(this.difficulty, duration) : _duration = duration;

  /// Returns the game duration
  int get duration => _duration;

  /// Adjust the game duration
  set duration(int value) {
    if (value <= 0)
      throw GameSettingsException(
          message: 'Game duration cannot be less than zero.');
    if (value > 120)
      throw GameSettingsException(
          message: 'Game duration cannot exceed 2 min.');

    _duration = value;
  }
}

class Game extends Model {
  String gameCode;
  GameState _gameState;
  bool _isPaused;
  GameSettings _gameSettings;

  /// Create a new game instance in a not started state
  Game.newGame()
      : _gameState = GameState.notStarted,
        _isPaused = false,
        _gameSettings = GameSettings(GameDifficulty.easy, 30),
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

  /// Get game setting
  GameSettings get gameSettings => _gameSettings;

  /// Pause a started game
  bool pauseGame() {
    if (!canPause) return false;

    _isPaused = true;
    return _isPaused;
  }

  /// Change difficulty
  GameSettings changeDifficuty(GameDifficulty newDifficulty) {
    if (!canChangeState) throw EndedGameException(game: this);
    if (_gameState == GameState.started)
      throw GameAlreadyStartedException(game: this);

    _gameSettings.difficulty = newDifficulty;
    return _gameSettings;
  }

  /// Change duration
  GameSettings changeDuration(int newDuration) {
    if (!canChangeState) throw EndedGameException(game: this);
    if (_gameState == GameState.started)
      throw GameAlreadyStartedException(game: this);

    _gameSettings.duration = newDuration;
    return _gameSettings;
  }
}
