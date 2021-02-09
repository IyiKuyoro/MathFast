import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_fast/data/model.dart';

main() {
  group('Model', () {
    group('Model()', () {
      test('should create new model', () {
        Model model = Model();

        expect(model.errorMap, {});
      });
    });

    group('addError()', () {
      test('should add an error to model', () {
        Model model = Model();

        Key errorKey = Key('errorKey');
        model.addError(errorKey, 'This is an error');

        expect(model.errorMap[errorKey], 'This is an error');
      });
    });

    group('getErrorMessage()', () {
      test('should get error from model', () {
        Model model = Model();

        Key errorKey = Key('errorKey');
        model.addError(errorKey, 'This is an error');

        expect(model.getErrorMessage(errorKey), 'This is an error');
      });
    });

    group('clearError()', () {
      test('should clear error', () {
        Model model = Model();

        Key errorKey = Key('errorKey');
        model.addError(errorKey, 'This is an error');
        model.clearError(errorKey);

        expect(model.errorMap[errorKey], null);
      });
    });
  });
}
