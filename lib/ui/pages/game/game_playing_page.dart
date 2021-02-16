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
  final Key _stopGameErrorKey;

  GamePlayingPage({@required this.gameCode})
      : _stopGameErrorKey = Key('GamePlayingPage-$gameCode-StopGameEvent');

  @override
  Widget build(BuildContext context) {
    return GameProvider(
      gameCode: gameCode,
      child: BlocBuilder<GameBloc, Game>(
        builder: (BuildContext context, Game game) {
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
                    Stack(
                      children: [
                        Container(
                          height: 55,
                          child: Center(
                            child: ComfortaaText(
                              convertSecsToMin(game.gameSettings.duration),
                            ),
                          ),
                        ),
                        game.canEndGame
                            ? Positioned(
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    context.read<GameBloc>().add(
                                          StopGameEvent(
                                            errorKey: _stopGameErrorKey,
                                          ),
                                        );
                                    context.read<GamesBloc>().add(
                                          DeleteGameEvent(
                                            game: game,
                                          ),
                                        );
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'games',
                                      (_) => false,
                                    );
                                  },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    margin: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.power_settings_new_outlined,
                                        color: Color(0xffff1e1e),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
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
