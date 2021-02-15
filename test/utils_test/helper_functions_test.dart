import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/utils/helper_functions.dart';

main() {
  group('convertSecsToMin', () {
    test('should convert 120 secs to 2:00', () {
      String time = convertSecsToMin(120);

      expect(time, '2:00');
    });

    test('should convert 100 secs to 1:40', () {
      String time = convertSecsToMin(100);

      expect(time, '1:40');
    });

    test('should convert 10 secs to 0:10', () {
      String time = convertSecsToMin(10);

      expect(time, '0:10');
    });

    test('should convert 0 secs to 0:00', () {
      String time = convertSecsToMin(0);

      expect(time, '0:00');
    });

    test('should covert 60 secs to 1:00', () {
      String time = convertSecsToMin(60);

      expect(time, '1:00');
    });

    test('should convert -30 secs to 0:00', () {
      String time = convertSecsToMin(-30);

      expect(time, '0:00');
    });
  });
}
