import 'package:flutter/material.dart';
import 'dart:async';

class GameWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameWidgetState(180);
  }
}

class _GameWidgetState extends State<GameWidget> {
  int _duration;
  int get _minLeft {
    if (_duration < 60) return 0;

    return (_duration / 60).round();
  }

  int get _secondsLeft {
    if (_duration < 60) return _duration;

    return _duration.remainder(60);
  }

  void _reduceDuration() {
    setState(() {
      _duration -= 1;
    });
  }

  _GameWidgetState(this._duration);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Text(_minLeft.toString()),
            Text(':'),
            Text(_secondsLeft.toString()),
          ],
        ),
        RaisedButton(
          onPressed: () {
            Timer.periodic(Duration(seconds: 1), (timer) {
              _reduceDuration();
            });
          },
          child: const Text('Start', style: TextStyle(fontSize: 20)),
        ),
      ],
    ));
  }
}
