import 'dart:math';

import 'package:flutter/material.dart';

double percentOfScreenWidth(
  BuildContext context,
  double factor, {
  double maxSize = 350,
}) {
  return MediaQuery.of(context).size.width > maxSize
      ? maxSize
      : MediaQuery.of(context).size.width * factor;
}

/// Generate a code using alphanumeric characters.
/// [prefix] will be prepended to the generated code.
String genCode({String prefix}) {
  const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ012356789';
  Random _rnd = Random();

  String code = String.fromCharCodes(
    Iterable.generate(
      10,
      (_) => _chars.codeUnitAt(
        _rnd.nextInt(
          _chars.length,
        ),
      ),
    ),
  );

  return '$prefix$code'.toUpperCase();
}
