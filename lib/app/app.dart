import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:palcal/app/ui/views/main_view.dart';
import 'package:yaru/yaru.dart';

class PalCal extends StatelessWidget {
  const PalCal({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        title: 'CalPal',
        debugShowCheckedModeBanner: false,
        theme: yaru.theme,
        // darkTheme: yaru.darkTheme,
        home: Container(
          decoration: BoxDecoration(
            color: ThemeData.light().scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade700),
          ),
          height: 650,
          child: MainPage(),
        ),

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
