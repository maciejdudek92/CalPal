import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calpal/app/app.bottomsheets.dart';
import 'package:calpal/app/app.dialogs.dart';
import 'package:calpal/app/app.locator.dart';
import 'package:calpal/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yaru/yaru.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await YaruWindow.ensureInitialized();
  await YaruWindowTitleBar.ensureInitialized();
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(600, 650),
    skipTaskbar: false,
    backgroundColor: Colors.transparent,
    // titleBarStyle: TitleBarStyle.hidden,
    center: true,
    alwaysOnTop: false,
  );
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const CalPal());
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setHasShadow(true);
  });
}

class CalPal extends StatelessWidget {
  const CalPal({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        title: 'CalPal',
        debugShowCheckedModeBanner: false,
        theme: yaru.theme,
        initialRoute: Routes.startupView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
        // darkTheme: yaru.darkTheme,
        // home: Container(
        //   decoration: BoxDecoration(
        //     color: ThemeData.light().scaffoldBackgroundColor,
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: Colors.grey.shade700),
        //   ),
        //   height: 650,
        //   child: MainView(),
        // ),
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
      );
    });
  }
}
