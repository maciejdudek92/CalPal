import 'package:flutter/material.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';
import 'package:palcal/app/ui/shared/base_view.dart';
import 'package:yaru/yaru.dart';
import 'dart:io';
import 'package:scrollable_table_view/scrollable_table_view.dart';

class MainPage extends BaseView<EstimatorViewModel> {
  const MainPage({super.key});

  @override
  void onModelReady(EstimatorViewModel viewModel) {}

  @override
  Widget build(BuildContext context, EstimatorViewModel model, Widget? child) {
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
        title: const Text("CalPal ;)"),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(YaruIcons.plus),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: YaruExpansionPanel(
          children: [
            SizedBox(
              height: 350,
              child: SelectionArea(
                selectionControls: EmptyTextSelectionControls(),
                child: ScrollableTableView(
                  headers: [
                    "Numer projektu",
                    "Sztuk/karton",
                    "Sztuk/warstwa",
                    "Sztuk/paleta",
                    "Waga poj. kartonika",
                  ].map((label) {
                    return TableViewHeader(
                      width: 110,
                      label: label,
                      // labelFontSize: 5,
                      textStyle: TextStyle(fontSize: 10),
                    );
                  }).toList(),
                  rows: [
                    ["1234", "540", "5400", "64800", "ok. 9,15g"],
                    ["1234", "540", "5400", "64800", "ok. 9,15g"],
                  ].map((record) {
                    return TableViewRow(
                      height: 60,
                      cells: record.map((value) {
                        return TableViewCell(
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 10),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(),
            Container(),
          ],
          headers: const [
            Text("Klejone"),
            Text("Na płasko"),
            Text("Clamshell'e"),
          ],
        ),
      ),
    );
  }
}

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: YaruDialogTitleBar(
//         heroTag: 'bar2',
//         titleSpacing: 15,
//         centerTitle: true,
//         isActive: true,
//         isClosable: false,
//         isDraggable: true,
//         onShowMenu: (context) {},
//         style: YaruTitleBarStyle.normal,
//         title: const Text("Cardboard Palletization Estimator"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: YaruWindowControl(
//                 type: YaruWindowControlType.close,
//                 onTap: () async {
//                   exit(0);
//                 }),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(YaruIcons.plus),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         onPressed: () {},
//       ),
//       body: const Center(child: Text("Todo.")),
//     );
//   }
// }
