import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/ui/components/display/comfortaa_text.dart';
import 'package:math_fast/ui/pages/game/game_provider.dart';
import 'package:math_fast/utils/helper_functions.dart';

class GamePlayingPage extends StatelessWidget {
  final String gameCode;

  GamePlayingPage({@required this.gameCode});

  @override
  Widget build(BuildContext context) {
    return GameProvider(
      gameCode: gameCode,
      child: BlocBuilder<GameBloc, Game>(
        builder: (BuildContext context, Game game) {
          context.read<GameBloc>().add(
                StartGameEvent(
                  errorKey: Key('GamePlayingPage-${game.gameCode}'),
                ),
              );

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xffcdf3ff),
                    Color(0xffffffff),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        StreamBuilder<int>(
                          initialData: game.durationLeft,
                          stream: game.durationLeftStream,
                          builder:
                              (BuildContext context, AsyncSnapshot<int> time) {
                            return ComfortaaText(convertSecsToMin(time.data));
                          },
                        ),
                        InkWell(
                          onTap: () {
                            // TODO: Display end game modal
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all(15),
                            child: Center(
                              child: Icon(
                                Icons.power_settings_new_outlined,
                                color: Color(0xffff1e1e),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
