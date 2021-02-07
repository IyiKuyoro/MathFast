import 'package:flutter/material.dart';
import 'package:math_fast/utils/helper_functions.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color foreground;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double height;

  Button({
    this.text = "",
    this.onPressed,
    this.foreground = Colors.black,
    this.maxWidth = 300,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      width: percentOfScreenWidth(
        context,
        0.9,
        maxSize: maxWidth,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          this.text,
          style: TextStyle(
            color: foreground,
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
                  Theme.of(context).colorScheme.primaryVariant),
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
