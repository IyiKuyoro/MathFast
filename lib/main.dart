import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'app.dart';
import 'store/reducers.dart';
import 'store/Results.dart';

void main() {
  final store = new Store<List<Result>>(
    resultsReducers,
    initialState: [
      new Result(DateTime.now(), 10, 10),
      new Result(DateTime.now(), 10, 5),
      new Result(DateTime.now(), 10, 7),
      new Result(DateTime.now(), 10, 2),
    ],
  );

  runApp(new MathApp(store));
}
