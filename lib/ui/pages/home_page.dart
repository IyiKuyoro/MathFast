import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/ui/components/actions/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, HashMap<String, Game>>(
      builder: (
        BuildContext context,
        HashMap<String, Game> state,
      ) {
        return Container(
          child: Column(
            children: [
              Button(
                text: 'Play',
                onPressed: () {
                  CreateGameEvent createGameEvent = CreateGameEvent();
                  context.read<GamesBloc>().add(createGameEvent);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    'games/${createGameEvent.game.gameCode}/new',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
