import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static final RegExp _digitsOnly = RegExp(r'[^\d]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Return empty if new value is empty
    if (newValue.text.isEmpty) return newValue;

    // Only allow digits
    final String newText = newValue.text.replaceAll(_digitsOnly, '');
    if (newText.isEmpty) return newValue.copyWith(text: '');

    // Parse to integer
    final int number = int.parse(newText);

    // Add thousands separators
    final String formattedText = _formatNumber(number);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }
}

class PercentageInputFormatter extends TextInputFormatter {
  final bool allowOver100;
  static final _validInputRegex = RegExp(r'^(\d+)?(\.)?(\d+)?$');

  PercentageInputFormatter({this.allowOver100 = false});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Always allow empty field
    if (newValue.text.isEmpty) return newValue;

    // Check if new input is valid (digits and max one decimal point)
    if (!_validInputRegex.hasMatch(newValue.text)) {
      return oldValue; // Reject change but keep old value
    }

    // Handle multiple decimal points
    if (newValue.text.split('.').length > 2) {
      return oldValue;
    }

    // Handle cases where user just typed a decimal point
    if (newValue.text == '.') {
      return TextEditingValue(
        text: '0.',
        selection: TextSelection.collapsed(offset: 2),
      );
    }

    // Parse the value
    final parsedValue = double.tryParse(newValue.text);

    // Handle invalid numbers (like multiple decimal points)
    if (parsedValue == null) return oldValue;

    // Enforce maximum value if needed
    if (!allowOver100 && parsedValue > 100) return oldValue;

    // Accept the valid input
    return newValue;
  }
}
