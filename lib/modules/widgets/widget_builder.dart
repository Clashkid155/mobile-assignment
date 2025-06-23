import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/io/response.dart';
import 'package:mobile_assessment/model/errors_response.dart';

class ErrorAndDataHandlerScreen extends StatelessWidget {
  const ErrorAndDataHandlerScreen({
    super.key,
    required this.response,
    this.showWidget,
    this.errorWidget,
    this.loading,
    this.isLoading = false,
    required this.widgetBuilder,
  });

  final Widget? showWidget;

  /// Indicates loading state
  final bool isLoading;

  /// Shows when there's an error.
  // final Widget? showErrorWidget;
  final Widget Function(List<ErrorsResponse> value)? errorWidget;

  /// Shows when loading is true
  final Widget? loading;
  final Widget Function(SuccessDataResponse? value) widgetBuilder;
  final StatusResponse? response;

  @override
  Widget build(BuildContext context) {
    return switch (isLoading) {
      false => switch (response?.errors) {
          null => widgetBuilder(response?.data as SuccessDataResponse?),
          _ => errorWidget?.call((response?.errors?..shuffle()) ?? []) ??
              SizedBox(),
        },
      true => loading ?? Container(),
    };
  }
}
