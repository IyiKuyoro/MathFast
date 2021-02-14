import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/ui/components/display/comfortaa_text.dart';

import '../../../config.dart';

main() {
  group('ComfortaaText', () {
    testWidgets('should render widget', (WidgetTester tester) async {
      ComfortaaText comfortaaText = ComfortaaText('Test');

      await tester.pumpWidget(testWidgetWrapper(comfortaaText));

      expect(find.text('Test'), findsOneWidget);
    });
  });
}
