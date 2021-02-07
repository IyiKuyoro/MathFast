import 'package:flutter/cupertino.dart';

class ComfortaaText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  ComfortaaText(
    this.text, {
    this.fontWeight: FontWeight.normal,
    this.fontSize: 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Comfortaa',
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
