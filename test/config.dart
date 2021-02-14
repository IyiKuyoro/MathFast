import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_fast/data/game/bloc.dart';
import 'package:math_fast/data/game/model.dart';

Widget testWidgetWrapper(Widget child) => MediaQuery(
      data: MediaQueryData(size: Size.square(400)),
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );

Widget testWidgetPageWrapper(
  Widget child,
  GamesBloc gamesBloc,
) =>
    MediaQuery(
      data: MediaQueryData(size: Size.square(400)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GamesBloc>(
            create: (BuildContext context) =>
                gamesBloc ?? GamesBloc(HashMap<String, Game>()),
          )
        ],
        child: MaterialApp(home: child),
      ),
    );
