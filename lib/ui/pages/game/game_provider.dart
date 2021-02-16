import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';

/// This widget is a wrapper widget for specific game root widgets
/// It handles acquiring the game with the specified [gameCode] from
/// the GamesBloc state and creating a GameBloc provider
class GameProvider extends StatelessWidget {
  final String gameCode;
  final Widget child;

  GameProvider({
    @required this.gameCode,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        Game game = context.read<GamesBloc>().state.getGame(gameCode);
        return GameBloc(game);
      },
      child: child,
    );
  }
}
