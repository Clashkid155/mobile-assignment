import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/theme/app_theme.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';

class MobileAssessmentApp extends StatefulWidget {
  final bool isDebug;

  const MobileAssessmentApp({super.key, this.isDebug = true});

  @override
  State<MobileAssessmentApp> createState() => _MobileAssessmentAppState();
}

class _MobileAssessmentAppState extends State<MobileAssessmentApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = ThemeProvider();
    return ListenableBuilder(
        listenable: themeProvider,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: widget.isDebug,
            theme: themeProvider.theme, // AppTheme.darkTheme(),
            home: HomeScreen(
              themeProvider: themeProvider,
            ),
          );
        });
  }
}
