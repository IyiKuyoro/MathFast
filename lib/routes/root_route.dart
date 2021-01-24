import 'package:flutter/material.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/routes/game_route.dart';
import 'package:math_fast/ui/pages/home_page.dart';

class RootRoutePath {
  final bool isUnknown;

  /// Create root route
  RootRoutePath() : this.isUnknown = false;

  /// Create an unknown route
  RootRoutePath.unknown() : this.isUnknown = true;
}

class AppRouteState extends ChangeNotifier {}

class AppRouterDelegate extends RouterDelegate<RootRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RootRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final GameBloc _gameBloc;
  Game _game;

  AppRouterDelegate({@required GameBloc gameBloc})
      : this._gameBloc = gameBloc,
        this.navigatorKey = GlobalKey<NavigatorState>() {
    _gameBloc.gameStream.listen((Game game) {
      _game = game;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: HomePage(),
            ),
          ),
        ),
        if (_game != null)
          MaterialPage(
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Text('Game ${_game.gameCode}'),
              ),
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        notifyListeners();
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RootRoutePath path) async {
    if (path is RootRoutePath) {
      _gameBloc.selectGame(null);
    } else if (path is GameRoutePath) {
      GameRoutePath gamePath = path;
      _gameBloc.selectGame(gamePath.game.gameCode);
    }
  }
}

class AppRouteInformationParser extends RouteInformationParser<RootRoutePath> {
  GameBloc _gameBloc;

  AppRouteInformationParser({@required GameBloc gameBloc})
      : this._gameBloc = gameBloc;

  @override
  Future<RootRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == '') {
      return RootRoutePath();
    } else if (uri.pathSegments.length == 3) {
      if (uri.pathSegments[0] == 'game') {
        String gameCode = uri.pathSegments[1];
        Game game = _gameBloc.selectGame(gameCode);

        return GameRoutePath(game: game);
      }
    }

    return RootRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(RootRoutePath path) {
    if (path is RootRoutePath) {
      return RouteInformation(location: '/');
    }
    if (path is GameRoutePath) {
      GameState gameState = path.game.gameState;
      RouteInformation routeInfo;

      switch (gameState) {
        case GameState.notStarted:
          routeInfo = RouteInformation(
            location: '/game/${path.game.gameCode}/new',
          );
          break;
        case GameState.started:
          routeInfo = RouteInformation(
            location: '/game/${path.game.gameCode}/playing',
          );
          break;
        case GameState.ended:
          routeInfo = RouteInformation(
            location: '/game/${path.game.gameCode}/ended',
          );
          break;
        default:
          break;
      }

      return routeInfo;
    }
    return null;
  }
}
