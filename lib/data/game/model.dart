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
  GameSettings(this.difficulty, duration) {
    _checkDuration(duration);
    _duration = duration;
  }

  /// Returns the game duration
  int get duration => _duration;

  /// Adjust the game duration
  set duration(int value) {
    _checkDuration(value);
    _duration = value;
  }

  /// Ensure game duration is greater than or equal to 10
  /// and less than or equal to 120
  static void _checkDuration(int duration) {
    if (duration < 10 || duration > 120) {
      throw GameSettingsException(
        message:
            'Game duration cannot be less than 10 Secs or greater than 2 Mins.',
      );
    }
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

  /// Checks if the game has ended or started
  bool get _canEditGame {
    if (!canChangeState) throw EndedGameException(game: this);
    if (_gameState == GameState.started)
      throw GameAlreadyStartedException(game: this);

    return true;
  }

  /// Pause a started game
  bool pauseGame() {
    if (!canPause) return false;

    _isPaused = true;
    return _isPaused;
  }

  /// Change difficulty
  GameSettings changeDifficuty(GameDifficulty newDifficulty) {
    _canEditGame;

    _gameSettings.difficulty = newDifficulty;
    return _gameSettings;
  }

  /// Change duration
  GameSettings changeDuration(int newDuration) {
    _canEditGame;

    _gameSettings.duration = newDuration;
    return _gameSettings;
  }

  /// Changes game state to start
  GameState startGame() {
    _canEditGame;

    return gameState = GameState.started;
  }

  /// End the game if not already ended
  GameState endGame() {
    if (gameState == GameState.ended) throw EndedGameException(game: this);

    return gameState = GameState.ended;
  }
}
