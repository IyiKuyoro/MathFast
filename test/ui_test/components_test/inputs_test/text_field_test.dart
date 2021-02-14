import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/ui/components/inputs/text_field.dart';

import '../../../config.dart';

main() {
  group('TextInput', () {
    testWidgets('should build widget', (WidgetTester tester) async {
      TextInput textInput = TextInput(
        name: 'TestInput',
        label: 'Text Input',
        widgetKey: Key('test-widget'),
      );

      await tester.pumpWidget(testWidgetWrapper(textInput));

      expect(find.text('Text Input'), findsOneWidget);
    });
  });
}
