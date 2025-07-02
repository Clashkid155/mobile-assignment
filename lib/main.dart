import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mobile_assessment/common/database.dart';
import 'package:mobile_assessment/root_widget.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppDatabase.init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(DevicePreview(
      builder: (context) => const MobileAssessmentApp(
        isDebug: true,
      ),
    ));
  }, (exception, stackTrace) async {});
}
