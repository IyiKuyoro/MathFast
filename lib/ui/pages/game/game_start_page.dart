import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/event.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/ui/components/actions/button.dart';
import 'package:math_fast/ui/components/inputs/option_selector.dart';
import 'package:math_fast/ui/components/inputs/text_field.dart';
import 'package:math_fast/ui/pages/game/game_provider.dart';

class GameStartPage extends StatefulWidget {
  final String gameCode;

  GameStartPage({@required this.gameCode});

  @override
  State<StatefulWidget> createState() {
    return _GameStartPageState(gameCode: gameCode);
  }
}

class _GameStartPageState extends State<GameStartPage> {
  final String gameCode;
  bool isValid = true;
  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'Game-Settings');
  final Key _startGameErrorKey;

  _GameStartPageState({@required this.gameCode})
      : _startGameErrorKey = Key('GamePlayingPage-$gameCode-StartGameEvent');

  Widget durationInput(BuildContext context, Game game) {
    Key errorKey = Key('Game-Start-Page-Duration');

    return TextInput(
      label: 'Duration (Secs)',
      name: 'duration',
      errorText: game.getErrorMessage(errorKey),
      onChanged: (String duration) {
        if (_formKey.currentState.saveAndValidate()) {
          ChangeGameDuration changeGameDurationEvent = ChangeGameDuration(
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
    return GameProvider(
      gameCode: gameCode,
      child: BlocBuilder<GameBloc, Game>(
        builder: (BuildContext context, Game game) {
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
                            // Delete game since it was not started
                            context.read<GamesBloc>().add(
                                  DeleteGameEvent(
                                    game: game,
                                  ),
                                );
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
                        onChanged: (_) {
                          if (_formKey.currentState != null &&
                              _formKey.currentState.validate()) {
                            setState(() {
                              isValid = true;
                            });
                          } else {
                            setState(() {
                              isValid = false;
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            durationInput(context, game),
                            difficultyInput(context, game),
                            Button(
                              text: 'Start',
                              foreground: Theme.of(context).colorScheme.primary,
                              maxWidth: 300,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              margin: EdgeInsets.only(top: 30),
                              disabled: !isValid,
                              onPressed: () {
                                context.read<GameBloc>().add(
                                      StartGameEvent(
                                        errorKey: _startGameErrorKey,
                                      ),
                                    );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'games/${game.gameCode}/playing',
                                  (_) => false,
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
  }
}
