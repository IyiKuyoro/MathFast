import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/utils/exceptions/game_exceptions.dart';

main() {
  group('GameSettings', () {
    group('GameSettings()', () {
      test('should create game setting with correct parameters', () {
        GameSettings gameSettings = GameSettings(GameDifficulty.easy, 120);

        expect(gameSettings.difficulty, GameDifficulty.easy);
      });

      test(
        'should error if game duration is set outside boundary 10 - 120',
        () {
          expect(
            () => GameSettings(GameDifficulty.easy, 121),
            throwsA(
              isA<GameSettingsException>(),
            ),
          );
        },
      );
    });
  });

  group('Game', () {
    group('Game()', () {
      test('should create a new game', () {
        Game game = Game();

        expect(game.gameSettings.difficulty, GameDifficulty.easy);
        expect(game.gameSettings.duration, 30);
        expect(game.gameState, GameState.notStarted);
        expect(game.isPaused, false);
      });
    });

    group('Game.newGame()', () {
      test('should create a new game', () {
        Game game = Game.newGame();

        expect(game.gameSettings.difficulty, GameDifficulty.easy);
        expect(game.gameSettings.duration, 30);
        expect(game.gameState, GameState.notStarted);
        expect(game.isPaused, false);
      });
    });

    group('togglePauseGame()', () {
      test('should be able to pause a started game', () {
        Game game = Game(gameState: GameState.started);

        game = game.toggleGamePause();

        expect(game.isPaused, true);
      });

      test(
        'should not be able to pause game that is not in a started state',
        () {
          Game game = Game(gameState: GameState.ended);

          expect(
            () {
              game.toggleGamePause();
            },
            throwsA(isA<GameException>()),
          );
        },
      );
    });

    group('changeDifficulty()', () {
      test('should change difficulty', () {
        Game game = Game.newGame();
        game = game.changeDifficuty(GameDifficulty.hard);

        expect(game.gameSettings.difficulty, GameDifficulty.hard);
      });

      test('should error if game has ended', () {
        Game game = Game(gameState: GameState.ended);

        expect(
          () {
            game.changeDifficuty(GameDifficulty.medium);
          },
          throwsA(isA<EndedGameException>()),
        );
      });

      test('should error if game has started', () {
        Game game = Game(gameState: GameState.started);

        expect(
          () {
            game.changeDifficuty(GameDifficulty.medium);
          },
          throwsA(isA<GameAlreadyStartedException>()),
        );
      });
    });

    group('changeDuration()', () {
      test('should change duration', () {
        Game game = Game.newGame();
        game = game.changeDuration(20);

        expect(game.gameSettings.duration, 20);
      });

      test('should error if game has ended', () {
        Game game = Game(gameState: GameState.ended);

        expect(
          () {
            game.changeDuration(20);
          },
          throwsA(isA<EndedGameException>()),
        );
      });

      test('should error if game has started', () {
        Game game = Game(gameState: GameState.started);

        expect(
          () {
            game.changeDuration(50);
          },
          throwsA(isA<GameAlreadyStartedException>()),
        );
      });

      test('should error if specified duration is outside range', () {
        Game game = Game.newGame();

        expect(
          () {
            game.changeDuration(9);
          },
          throwsA(isA<GameSettingsException>()),
        );
      });
    });
  });
}
