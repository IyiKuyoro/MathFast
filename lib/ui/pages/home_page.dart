import 'package:flutter/material.dart';
import 'package:math_fast/ui/components/actions/button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Button(text: 'Play'),
        ],
      ),
    );
  }
}
