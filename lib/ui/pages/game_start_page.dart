import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/ui/components/actions/button.dart';
import 'package:math_fast/ui/components/inputs/option_selector.dart';
import 'package:math_fast/ui/components/inputs/text_field.dart';

class GameStartPage extends StatelessWidget {
  final String gameCode;
  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'Game-Settings');

  GameStartPage({@required this.gameCode});

  Widget durationInput(BuildContext context, Game game) {
    Key errorKey = Key('Game-Start-Page-Duration');

    return TextInput(
      label: 'Duration (Secs)',
      name: 'duration',
      errorText: game.getErrorMessage(errorKey),
      onChanged: (String duration) {
        if (_formKey.currentState.saveAndValidate()) {
          ChangeGameDuration changeGameDurationEvent = ChangeGameDuration(
            game: game,
            newDuration: int.parse(duration),
            errorKey: errorKey,
          );
          context.read<GameBloc>().add(changeGameDurationEvent);
        }
      },
      inputType: TextInputType.number,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
        FormBuilderValidators.max(120),
        FormBuilderValidators.min(10),
      ],
    );
  }

  Widget difficultyInput(BuildContext context, Game game) {
    Key errorKey = Key('Game-Start-Page-Difficulty');

    return OptionSelector(
      label: 'Difficulty',
      name: 'difficulty',
      onChanged: (GameDifficulty difficulty) {
        context.read<GameBloc>().add(
              ChangeGameDifficulty(
                game: game,
                newDifficulty: difficulty,
                errorKey: errorKey,
              ),
            );
      },
      options: <DropdownMenuItem>[
        DropdownMenuItem(
          value: GameDifficulty.easy,
          child: Center(
            child: Text('easy'),
          ),
        ),
        DropdownMenuItem(
          value: GameDifficulty.medium,
          child: Center(
            child: Text('medium'),
          ),
        ),
        DropdownMenuItem(
          value: GameDifficulty.hard,
          child: Center(
            child: Text('hard'),
          ),
        ),
      ],
      validators: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, HashMap<String, Game>>(
      builder: (BuildContext context, HashMap<String, Game> gamesState) {
        Game game = gamesState[gameCode];

        return BlocProvider(
          create: (BuildContext context) => GameBloc(game),
          child: BlocBuilder<GameBloc, Game>(
            builder: (BuildContext context, Game state) {
              return Scaffold(
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
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
                    child: Stack(
                      children: [
                        if (Navigator.canPop(context))
                          SafeArea(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(15),
                                child: Center(
                                  child: Icon(Icons.arrow_back_ios_rounded),
                                ),
                              ),
                            ),
                          ),
                        Center(
                          child: FormBuilder(
                            key: _formKey,
                            initialValue: {
                              'duration': '30',
                              'difficulty': GameDifficulty.easy,
                            },
                            onChanged: (_) {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                durationInput(context, game),
                                difficultyInput(context, game),
                                Button(
                                  text: 'Start',
                                  foreground:
                                      Theme.of(context).colorScheme.primary,
                                  maxWidth: 300,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  margin: EdgeInsets.only(top: 30),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      'games/${game.gameCode}/playing',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
