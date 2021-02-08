import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:math_fast/ui/components/display/comfortaa_text.dart';
import 'package:math_fast/utils/helper_functions.dart';

class TextInput extends StatelessWidget {
  final Key widgetKey;
  final String name;
  final String label;
  final TextInputType inputType;
  final Function onChanged;
  final List<String Function(dynamic)> validators;
  final String errorText;

  TextInput({
    this.widgetKey,
    @required this.name,
    this.onChanged,
    this.inputType,
    this.label = '',
    this.validators = const [],
    this.errorText,
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
              onChanged: (value) => onChanged(value),
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w100,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                errorText: errorText,
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
