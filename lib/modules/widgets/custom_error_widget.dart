import 'package:flutter/material.dart';
import 'package:mobile_assessment/generated/assets.dart';

class CustomErrorWidget extends StatefulWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  State<CustomErrorWidget> createState() => _CustomErrorWidgetState();
}

class _CustomErrorWidgetState extends State<CustomErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(Assets.assetsIcons8Error),
              Text(widget.errorMessage,
                  style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
