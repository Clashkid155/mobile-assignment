import 'package:flutter/widgets.dart';

/// TextFormField validators
class Validator {
  static String? required(String? value,
      {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value,
      {String message = 'Enter a valid email'}) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  static String? digit(String? value,
      {String message = 'Enter a valid number'}) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r'^\d+\.?\d*$');
    if (!regex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  static String? text(String? value, {String message = 'Enter a valid text'}) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r"^[\p{L}]+(?:[' -][\p{L}]+)*$", unicode: true);
    if (!regex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  static String? minLength(String? value, int min, {String? message}) {
    if (value != null && value.trim().length < min) {
      return message ?? 'Minimum $min characters required';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? message}) {
    if (value != null && value.trim().length > max) {
      return message ?? 'Maximum $max characters allowed';
    }
    return null;
  }

  static String? pattern(String? value, String pattern,
      {String message = 'Invalid format'}) {
    if (value != null && !RegExp(pattern).hasMatch(value)) {
      return message;
    }
    return null;
  }

  static FormFieldValidator<String> combine(
      List<FormFieldValidator<String?>> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  static FormFieldValidator<String> match(
    TextEditingController otherController, {
    String message = 'Fields do not match',
  }) {
    return (value) {
      if (value != otherController.text) {
        return message;
      }
      return null;
    };
  }
}
