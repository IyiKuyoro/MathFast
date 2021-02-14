import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/ui/pages/home_page.dart';

import '../../config.dart';

main() {
  group('HomePage', () {
    testWidgets(
      'should display play button on home page',
      (WidgetTester tester) async {
        HomePage homePage = HomePage();

        await tester.pumpWidget(testWidgetPageWrapper(homePage, null));

        expect(find.text('Play'), findsOneWidget);
      },
    );
  });
}
