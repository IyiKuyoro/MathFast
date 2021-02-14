import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';

class GamePlayingPage extends StatelessWidget {
  final String gameCode;

  GamePlayingPage({@required this.gameCode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, HashMap<String, Game>>(
      builder: (BuildContext context, HashMap<String, Game> gamesState) {
        Game game = gamesState[gameCode];

        return SafeArea(
          child: Text(
            "Now playing ${game.gameCode} for ${game.gameSettings.duration} secs.",
          ),
        );
      },
    );
  }
}
