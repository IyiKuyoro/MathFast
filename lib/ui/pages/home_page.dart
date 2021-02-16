import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/ui/components/actions/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                text: 'Play',
                onPressed: () {
                  CreateGameEvent createGameEvent = CreateGameEvent();
                  context.read<GamesBloc>().add(createGameEvent);
                  Navigator.pushNamed(
                    context,
                    'games/${createGameEvent.game.gameCode}/new',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
