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
