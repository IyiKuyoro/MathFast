import 'package:flutter/material.dart';
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
  int duration;

  /// Create new game settings
  GameSettings(this.difficulty, int duration) {
    _checkDuration(duration);
    this.duration = duration;
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

@immutable
class Game extends Model<Game> {
  final String gameCode;
  final GameState gameState;
  final bool isPaused;
  final GameSettings gameSettings;

  /// Create a game by passing parameters of the game
  Game({
    String gameCode,
    GameSettings gameSettings,
    this.gameState: GameState.notStarted,
    this.isPaused: false,
    Map<Key, dynamic> errorMap,
  })  : this.gameCode = gameCode ?? genCode(prefix: 'GAM'),
        this.gameSettings =
            gameSettings ?? GameSettings(GameDifficulty.easy, 30),
        super(errorMap: errorMap ?? {});

  /// Create a new game instance in a not started state
  Game.newGame()
      : gameState = GameState.notStarted,
        isPaused = false,
        gameSettings = GameSettings(GameDifficulty.easy, 30),
        gameCode = genCode(prefix: 'GAM'),
        super();

  /// Can the current game be paused of not
  bool get canPause => gameState == GameState.started;

  /// Is the game in an ended state
  bool get hasEnded => gameState == GameState.ended;

  /// Is the game in a started state
  bool get hasStarted => gameState == GameState.started;

  /// Can the game be ended
  bool get canEndGame => gameState != GameState.ended;

  /// Pause a started game
  Game toggleGamePause() {
    if (!canPause)
      throw GameException(
        game: this,
        message: 'Cannot pause a game that is not in the started state.',
      );

    return copyWith(isPaused: !isPaused);
  }

  /// Change difficulty
  Game changeDifficuty(GameDifficulty newDifficulty) {
    if (hasEnded) throw EndedGameException(game: this);
    if (hasStarted) throw GameAlreadyStartedException(game: this);

    return copyWith(
      gameSettings: GameSettings(
        newDifficulty,
        gameSettings.duration,
      ),
    );
  }

  /// Change duration
  Game changeDuration(int newDuration) {
    if (hasEnded) throw EndedGameException(game: this);
    if (hasStarted) throw GameAlreadyStartedException(game: this);

    return copyWith(
      gameSettings: GameSettings(
        gameSettings.difficulty,
        newDuration,
      ),
    );
  }

  /// Changes game state to start
  Game startGame() {
    if (hasEnded) throw EndedGameException(game: this);
    if (hasStarted) throw GameAlreadyStartedException(game: this);

    return copyWith(gameState: GameState.started);
  }

  /// End the game if not already ended
  Game endGame() {
    if (canEndGame) {
      return copyWith(gameState: GameState.ended);
    }

    throw EndedGameException(game: this);
  }

  Game copyWith({
    GameState gameState,
    bool isPaused,
    GameSettings gameSettings,
    Map<Key, dynamic> errorMap,
  }) =>
      Game(
        gameCode: this.gameCode,
        gameState: gameState ?? this.gameState,
        isPaused: isPaused ?? this.isPaused,
        gameSettings: gameSettings ?? this.gameSettings,
        errorMap: errorMap ?? this.errorMap,
      );
}

@immutable
class Games extends Model<Games> {
  final Map<String, Game> gamesMap;

  Games({
    this.gamesMap: const {},
    Map<Key, dynamic> errorMap,
  }) : super(errorMap: errorMap ?? {});

  @override
  Games copyWith({
    Map<Key, dynamic> errorMap,
    Map<String, Game> gamesMap,
  }) =>
      Games(
        gamesMap: gamesMap ?? this.gamesMap,
        errorMap: errorMap ?? this.errorMap,
      );

  Games upsertGame(Game game) {
    Map<String, Game> modifiedGamesMap = {...gamesMap};
    modifiedGamesMap[game.gameCode] = game;

    return copyWith(gamesMap: modifiedGamesMap);
  }

  Games removeGame(String gameCode) {
    Map<String, Game> modifiedGamesMap = {...gamesMap};
    modifiedGamesMap.remove(gameCode);

    return copyWith(gamesMap: modifiedGamesMap);
  }

  Game getGame(String gameCode) {
    return gamesMap[gameCode];
  }
}
