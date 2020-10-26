import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'Pages/home.dart';
import 'store/Results.dart';

class MathApp extends StatelessWidget {
  final Store<List<Result>> store;

  MathApp(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<List<Result>>(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Tutorial',
        home: new Home(),
      ),
    );
  }
}
