import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/ui/components/actions/button.dart';

import '../../../config.dart';

main() {
  group('Button', () {
    testWidgets('should build widget', (WidgetTester tester) async {
      Button button = Button(
        text: 'Test Button',
      );

      await tester.pumpWidget(testWidgetWrapper(button));

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('should callback on pressed', (WidgetTester tester) async {
      bool pressed = false;
      Button button = Button(
        text: 'Test Button',
        onPressed: () => pressed = true,
      );

      await tester.pumpWidget(testWidgetWrapper(button));
      await tester.tap(find.text('Test Button'));

      expect(pressed, true);
    });
  });
}
