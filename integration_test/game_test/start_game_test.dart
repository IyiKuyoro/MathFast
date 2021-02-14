import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:math_fast/main.dart';
import 'package:math_fast/ui/components/inputs/option_selector.dart';
import 'package:math_fast/ui/components/inputs/text_field.dart';

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Start-Game', () {
    testWidgets(
      'render play button and navigate to settings screen',
      (WidgetTester tester) async {
        await tester.pumpWidget(MathFastApp());

        await tester.tap(find.text('Play'));
        await tester.pumpAndSettle();

        expect(find.text('Duration (Secs)'), findsOneWidget);
        expect(find.text('30'), findsOneWidget);
        expect(find.text('Difficulty'), findsOneWidget);
        expect(find.text('easy'), findsOneWidget);
      },
    );

    testWidgets(
      'modify game settings correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(MathFastApp());

        await tester.tap(find.text('Play'));
        await tester.pumpAndSettle();

        String duration = '90';
        await tester.enterText(find.byType(TextInput), duration);
        await tester.tap(find.byType(OptionSelector));
        await tester.pump();
        await tester.pump(Duration(milliseconds: 100));
        await tester.tap(find.text('medium').last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        // For very misterious reasons, this has to be done twice
        await tester.tap(find.text('medium').last);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.text('90'), findsOneWidget);
        expect(find.text('30'), findsNothing);
        expect(find.text('medium').hitTestable(), findsOneWidget);
        expect(find.text('easy').hitTestable(), findsNothing);
      },
    );

    testWidgets(
      'modify game settings and error on incorrect settings',
      (WidgetTester tester) async {
        await tester.pumpWidget(MathFastApp());

        await tester.tap(find.text('Play'));
        await tester.pumpAndSettle();

        String duration = '121';
        await tester.enterText(find.byType(TextInput), duration);
        await tester.pumpAndSettle(Duration(milliseconds: 100));
        expect(
          find.text('Value must be less than or equal to 120'),
          findsOneWidget,
        );

        duration = '9';
        await tester.enterText(find.byType(TextInput), duration);
        await tester.pumpAndSettle(Duration(milliseconds: 100));
        expect(
          find.text('Value must be greater than or equal to 10'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'modify game setings and navigate to game page',
      (WidgetTester tester) async {
        await tester.pumpWidget(MathFastApp());

        await tester.tap(find.text('Play'));
        await tester.pumpAndSettle();

        // Modify settings
        String duration = '90';
        await tester.enterText(find.byType(TextInput), duration);
        await tester.tap(find.byType(OptionSelector));
        await tester.pump();
        await tester.pump(Duration(milliseconds: 100));
        await tester.tap(find.text('medium').last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.text('medium').last);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        // Navigate
        await tester.tap(find.text('Start'));
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'navigate back to the start page when back is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(MathFastApp());

        await tester.tap(find.text('Play'));
        await tester.pumpAndSettle();

        // Navigate
        await tester.tap(find.byIcon(Icons.arrow_back_ios_rounded));
        await tester.pumpAndSettle();

        expect(find.text('Play'), findsOneWidget);
      },
    );
  });
}
