import 'package:flutter/material.dart';

class InitialIcon extends StatelessWidget {
  const InitialIcon({super.key, required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Center(
        child: Text(
          initials,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}
