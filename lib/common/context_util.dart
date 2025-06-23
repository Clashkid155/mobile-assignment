import 'package:flutter/material.dart';

extension NavigationUtility<T> on BuildContext {
  /// Push the given route(`to`) onto the navigation stack
  Future<T?> push(Widget to) => Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => to,
      ));

  /// Pop current route on dialog
  void pop([Object? returnAble]) => Navigator.pop(this, returnAble);
}
