import 'package:flutter/material.dart';

@immutable
abstract class Model<T> {
  final Map<Key, dynamic> errorMap;

  Model({Map<Key, dynamic> errorMap}) : this.errorMap = errorMap ?? {};

  T copyWith({Map<Key, dynamic> errorMap});

  T addError(Key errorKey, String error) {
    Map<Key, dynamic> modifiedErrorMap = {...errorMap};
    modifiedErrorMap[errorKey] = error;

    return copyWith(errorMap: modifiedErrorMap);
  }

  T removeError(Key errorKey) {
    Map<Key, dynamic> modifiedErrorMap = {...errorMap};
    modifiedErrorMap.remove(errorKey);

    return copyWith(errorMap: modifiedErrorMap);
  }

  /// Get error message
  String getErrorMessage(Key errorKey) {
    return errorMap[errorKey];
  }
}
