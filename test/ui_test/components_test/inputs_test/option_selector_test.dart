import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/ui/components/inputs/option_selector.dart';

import '../../../config.dart';

main() {
  group('OptionSelector', () {
    testWidgets('should build widget', (WidgetTester tester) async {
      OptionSelector optionSelector = OptionSelector(
        name: 'testSelect',
        widgetKey: Key('test-widget'),
        label: 'Test Selector',
      );

      await tester.pumpWidget(testWidgetWrapper(optionSelector));

      expect(find.text('Test Selector', skipOffstage: false), findsOneWidget);
    });

    testWidgets('should render dropdown items', (WidgetTester tester) async {
      OptionSelector optionSelector = OptionSelector(
        name: 'testSelect',
        widgetKey: Key('test-widget'),
        label: 'Test Selector',
        options: [
          DropdownMenuItem(child: Text('Option-One'), value: 'Option-One'),
          DropdownMenuItem(child: Text('Option-Two'), value: 'Option-Two'),
        ],
      );

      await tester.pumpWidget(testWidgetWrapper(optionSelector));
      await tester.tap(find.text('Test Selector'));

      expect(find.text('Option-One', skipOffstage: false), findsOneWidget);
      expect(find.text('Option-Two', skipOffstage: false), findsOneWidget);
    });
  });
}
