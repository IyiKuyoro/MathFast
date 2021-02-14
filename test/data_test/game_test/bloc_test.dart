import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';

main() {
  group('GameBloc', () {
    group('StartGameEvent', () {
      blocTest(
        'should change game state to started',
        build: () => GameBloc(
          Game.newGame(),
        ),
        act: (GameBloc gameBloc) => gameBloc.add(
          StartGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(game.gameState, GameState.started);
        },
      );

      blocTest(
        'should error if game has ended',
        build: () {
          Game game = Game.newGame();
          game.startGame();

          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          StartGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has already started.',
          );
        },
      );

      blocTest(
        'should error if game has already started',
        build: () {
          Game game = Game.newGame();
          game.endGame();

          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          StartGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has ended.',
          );
        },
      );
    });

    group('StopGameEvent', () {
      blocTest(
        'should change game state to ended',
        build: () => GameBloc(
          Game.newGame(),
        ),
        act: (GameBloc gameBloc) => gameBloc.add(
          StopGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(game.gameState, GameState.ended);
        },
      );

      blocTest(
        'should error if game has already ended',
        build: () {
          Game game = Game.newGame();
          game.endGame();

          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          StopGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has ended.',
          );
        },
      );
    });

    group('PauseGameEvent', () {
      blocTest(
        'should pause the game',
        build: () {
          Game game = Game.newGame();
          game.startGame();
          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          PauseGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(game.isPaused, true);
        },
      );

      blocTest(
        'should error if game is not started',
        build: () {
          Game game = Game.newGame();
          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          PauseGameEvent(
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.isPaused,
            false,
          );
        },
      );
    });

    group('ChangeGameDuration', () {
      blocTest(
        'should change game duration',
        build: () => GameBloc(
          Game.newGame(),
        ),
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDuration(
            newDuration: 100,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(game.gameSettings.duration, 100);
        },
      );

      blocTest(
        'should error if game has ended',
        build: () {
          Game game = Game.newGame();
          game.endGame();
          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDuration(
            newDuration: 100,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has ended.',
          );
        },
      );

      blocTest(
        'should error if game has started',
        build: () {
          Game game = Game.newGame();
          game.startGame();
          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDuration(
            newDuration: 100,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has already started.',
          );
        },
      );

      blocTest(
        'should error if game duration is less than 10',
        build: () => GameBloc(
          Game.newGame(),
        ),
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDuration(
            newDuration: 9,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game duration cannot be less than 10 Secs or greater than 2 Mins.',
          );
        },
      );
    });

    group('ChangeGameDifficulty', () {
      blocTest(
        'should change game difficulty',
        build: () => GameBloc(
          Game.newGame(),
        ),
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDifficulty(
            newDifficulty: GameDifficulty.hard,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(game.gameSettings.difficulty, GameDifficulty.hard);
        },
      );

      blocTest(
        'should error if game has ended',
        build: () {
          Game game = Game.newGame();
          game.endGame();
          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDifficulty(
            newDifficulty: GameDifficulty.hard,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has ended.',
          );
        },
      );

      blocTest(
        'should error if game has started',
        build: () {
          Game game = Game.newGame();
          game.startGame();
          return GameBloc(game);
        },
        act: (GameBloc gameBloc) => gameBloc.add(
          ChangeGameDifficulty(
            newDifficulty: GameDifficulty.hard,
            errorKey: Key('test-error-key'),
          ),
        ),
        expect: [isA<Game>()],
        verify: (GameBloc gameBloc) {
          Game game = gameBloc.state;

          expect(
            game.errorMap[Key('test-error-key')],
            'Game with code ${game.gameCode} has already started.',
          );
        },
      );
    });
  });

  group('GamesBloc', () {
    group('CreateGameEvent', () {
      blocTest(
        'should create new game',
        build: () => GamesBloc(HashMap<String, Game>()),
        act: (GamesBloc gamesBloc) => gamesBloc.add(CreateGameEvent()),
        expect: [isA<HashMap<String, Game>>()],
        verify: (GamesBloc gamesBloc) {
          int gamesNum = gamesBloc.state.length;
          expect(gamesNum, 1);
        },
      );
    });

    group('DeleteGameEvent', () {
      blocTest(
        'should delete an exisiting game',
        build: () {
          HashMap<String, Game> gamesMap = HashMap<String, Game>();
          Game game = Game.newGame();
          gamesMap[game.gameCode] = game;
          return GamesBloc(gamesMap);
        },
        act: (GamesBloc gamesBloc) {
          Game game = gamesBloc.state.values.first;

          gamesBloc.add(DeleteGameEvent(game: game));
        },
        expect: [isA<HashMap<String, Game>>()],
        verify: (GamesBloc gamesBloc) {
          int gamesNum = gamesBloc.state.length;
          expect(gamesNum, 0);
        },
      );
    });
  });
}
