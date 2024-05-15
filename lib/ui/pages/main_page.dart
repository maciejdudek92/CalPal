import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: YaruDialogTitleBar(
        heroTag: 'bar2',
        titleSpacing: 15,
        centerTitle: true,
        isActive: true,
        isClosable: false,
        isDraggable: true,
        onShowMenu: (context) {},
        style: YaruTitleBarStyle.normal,
        title: const Text("Cardboard Palletization Estimator"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: YaruWindowControl(
                type: YaruWindowControlType.close,
                onTap: () async {
                  exit(0);
                }),
          ),
        ],
      ),
      body: const Center(child: Text("Brak surowców pasujących do wyszukiwanej frazy.")),
    );
  }
}
