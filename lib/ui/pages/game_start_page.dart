import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';
import 'package:math_fast/data/settings/model.dart';
import 'package:math_fast/ui/components/actions/button.dart';
import 'package:math_fast/ui/components/inputs/option_selector.dart';
import 'package:math_fast/ui/components/inputs/text_field.dart';

class GameStartPage extends StatelessWidget {
  final String gameCode;
  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'Game-Settings');

  GameStartPage({@required this.gameCode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, HashMap<String, Game>>(
      builder: (BuildContext context, HashMap<String, Game> gamesState) {
        Game game = gamesState[gameCode];

        return BlocBuilder(
          cubit: GameBloc(game),
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
                              TextInput(
                                label: 'Duration (Secs)',
                                name: 'duration',
                                inputType: TextInputType.number,
                                validators: [],
                              ),
                              OptionSelector(
                                label: 'Difficulty',
                                name: 'difficulty',
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
                              ),
                              Button(
                                text: 'Start',
                                foreground:
                                    Theme.of(context).colorScheme.primary,
                                maxWidth: 300,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                margin: EdgeInsets.only(top: 30),
                                onPressed: () {},
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
        );
      },
    );
  }
}
