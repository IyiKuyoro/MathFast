import 'package:flutter/material.dart';

class MathApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorial',
      home: Center(
        child: Container(
          child: Image.asset(
            'assets/MathFastLogo.png',
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}
