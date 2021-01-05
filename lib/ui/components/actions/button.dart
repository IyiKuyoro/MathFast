import 'package:flutter/material.dart';
import 'package:math_fast/utils/helper_functions.dart';

class Button extends StatelessWidget {
  final String text;

  Button({this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: percentOfScreenWidth(
        context,
        0.9,
        maxSize: 300,
      ),
      child: ElevatedButton(
        onPressed: () {
          print("Pressed");
        },
        child: Text(
          this.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 18.0,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (Set<MaterialState> states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return 0.0;

              return 4;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  Theme.of(context).colorScheme.primary),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Theme.of(context).colorScheme.primaryVariant;

              return Theme.of(context).colorScheme.background;
            },
          ),
        ),
      ),
    );
  }
}
