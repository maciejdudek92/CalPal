import 'package:flutter/material.dart';
import 'package:palcal/app.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaru/yaru.dart';

void main() async {
  await YaruWindow.ensureInitialized();
  await YaruWindowTitleBar.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(600, 650),
    skipTaskbar: false,
    backgroundColor: Colors.transparent,
    // titleBarStyle: TitleBarStyle.hidden,
    center: true,
    alwaysOnTop: false,
  );

  runApp(const PalCal());

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setHasShadow(true);
  });
}
