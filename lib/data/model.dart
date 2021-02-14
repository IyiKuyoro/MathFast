import 'package:flutter/material.dart';

class Model {
  Map<Key, dynamic> errorMap;

  Model() : errorMap = {};

  /// Clear error
  void clearError(Key errorKey) {
    errorMap.remove(errorKey);
  }

  /// Add error
  void addError(Key errorKey, String error) {
    errorMap[errorKey] = error;
  }

  /// Get error message
  String getErrorMessage(Key errorKey) {
    return errorMap[errorKey];
  }
}
