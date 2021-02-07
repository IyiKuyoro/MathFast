import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:math_fast/ui/components/display/comfortaa_text.dart';
import 'package:math_fast/utils/helper_functions.dart';

class TextInput extends StatelessWidget {
  final Key widgetKey;
  final String name;
  final String label;
  final TextInputType inputType;
  final List<String Function(dynamic)> validators;

  TextInput({
    this.widgetKey,
    @required this.name,
    this.inputType,
    this.label = '',
    this.validators = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: percentOfScreenWidth(context, 0.8, maxSize: 300),
      child: Column(
        children: [
          ComfortaaText(
            label,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          Container(
            height: 48,
            margin: EdgeInsets.only(top: 9),
            child: FormBuilderTextField(
              key: widgetKey,
              attribute: name,
              validators: validators,
              keyboardType: inputType,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w100,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ],
      ),
    );
  }
}
