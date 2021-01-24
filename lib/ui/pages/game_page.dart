import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';

class GameStartPage extends StatelessWidget {
  final String gameCode;

  GameStartPage({@required this.gameCode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, HashMap<String, Game>>(
      builder: (BuildContext context, HashMap<String, Game> gamesState) {
        Game game = gamesState[gameCode];

        return BlocBuilder(
          cubit: GameBloc(game),
          builder: (BuildContext context, Game state) {
            return Text('Awaiting the start of ${game.gameCode}');
          },
        );
      },
    );
  }
}
