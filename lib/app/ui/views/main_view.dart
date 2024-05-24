import 'package:flutter/material.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';
import 'package:palcal/app/ui/shared/base_view.dart';
import 'package:palcal/app/ui/views/estimator_form_view.dart';
import 'package:palcal/app/ui/views/glued_options_view.dart';
import 'package:yaru/yaru.dart';
import 'dart:io';
import 'package:scrollable_table_view/scrollable_table_view.dart';

class MainPage extends BaseView<EstimatorViewModel> {
  MainPage({super.key}) : super(stateMixin: StateMixin.singleTicketProvider);
  late TabController tabController;

  @override
  void initState(_, viewModel) {
    tabController = TabController(length: 3, vsync: _!);
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context, EstimatorViewModel viewModel, Widget? _) {
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
        title: const Text("Cal-Pal"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: YaruWindowControl(
              type: YaruWindowControlType.close,
              onTap: () async {
                exit(0);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: ()
            // {
            //   EstimationOption option = EstimationOption(
            //     name: "12345_1",
            //     layers: 10,
            //     height: 150,
            //     outerBoxes: [],
            //     flatCardboardBoxes: [],
            //   );
            //   model.addGluedOption(option);
            // },
            =>
            showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return EstimatorFormView();
          },
        ),
        child: const Icon(YaruIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: Column(
          children: [
            YaruTabBar(
              tabController: tabController,
              tabs: [
                YaruTab(label: 'Klejone'),
                YaruTab(label: 'Na płasko'),
                YaruTab(label: "Clamshell'e"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 450,
                child: YaruBorderContainer(
                  child: TabBarView(
                    controller: tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GluedOptionsView(),
                      GluedOptionsView(),
                      GluedOptionsView(),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: SizedBox(
            //     height: 450,
            //     child: YaruBorderContainer(
            //       child: TabBarView(
            //         controller: tabController,
            //         children: [
            //           model.gluedOptions.isEmpty
            //               ? const Center(
            //                   child: Text("Brak danych..."),
            //                 )
            //               : SelectionArea(
            //                   selectionControls: EmptyTextSelectionControls(),
            //                   child: Center(
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(5.0),
            //                       child: ScrollableTableView(
            //                         headers: [
            //                           "Numer projektu",
            //                           "Sztuk/karton",
            //                           "Sztuk/warstwa",
            //                           "Sztuk/paleta",
            //                           "Waga poj. kartonika",
            //                           "Wysokość palety",
            //                           "Waga palety",
            //                           "Szczegóły",
            //                         ].map((label) {
            //                           return TableViewHeader(
            //                             width: 70,
            //                             label: label,
            //                             textStyle: const TextStyle(fontSize: 10,

            //                             ),
            //                           );
            //                         }).toList(),
            //                         rows: model.gluedOptions.map((EstimationOption option) {
            //                           return TableViewRow(height: 40, cells: [
            //                             TableViewCell(
            //                               child: Text(
            //                                 option.name,
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                               child: Text(
            //                                 option.boxesPerOuter.toString(),
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                               child: Text(
            //                                 option.boxesPerLayer.toString(),
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                               child: Text(
            //                                 option.boxesPerPalette.toString(),
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                               child: Text(
            //                                 "${option.cardboardBoxWeight.toStringAsFixed(2)}g",
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                               child: Text(
            //                                 "${option.paletteHeight.toString()}m",
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                               child: Text(
            //                                 "ok. ${option.paletteWeight.toString()}kg",
            //                                 style: const TextStyle(fontSize: 10),
            //                               ),
            //                             ),
            //                             TableViewCell(
            //                                 child: IconButton(
            //                                     onPressed: () async => showDialog(
            //                                           barrierDismissible: true,
            //                                           context: context,
            //                                           builder: (context) {
            //                                             return SizedBox(
            //                                               height: 500,
            //                                               child: AlertDialog(
            //                                                 titlePadding: EdgeInsets.zero,
            //                                                 title: YaruDialogTitleBar(
            //                                                   title: Text(option.name),
            //                                                   isClosable: false,
            //                                                   actions: [
            //                                                     Padding(
            //                                                       padding: const EdgeInsets.only(right: 10.0),
            //                                                       child: YaruWindowControl(
            //                                                         type: YaruWindowControlType.close,
            //                                                         onTap: () async {
            //                                                           Navigator.maybePop(context);
            //                                                         },
            //                                                       ),
            //                                                     ),
            //                                                   ],
            //                                                 ),
            //                                                 content: SizedBox(
            //                                                   height: 400,
            //                                                   child: YaruBanner.tile(
            //                                                     surfaceTintColor: Colors.pink,
            //                                                     title: Text(
            //                                                       'Wymiar kartonu',
            //                                                     ),
            //                                                     subtitle: Text(
            //                                                       "${option.outerBoxes!.first.length}x${option.outerBoxes!.first.width}x${option.outerBoxes!.first.height}",
            //                                                     ),
            //                                                   ),
            //                                                 ),
            //                                               ),
            //                                             );
            //                                           },
            //                                         ),
            //                                     icon: const Icon(Icons.more_vert))),
            //                           ]);
            //                         }).toList(),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //           model.flatOptions.isEmpty
            //               ? const Padding(
            //                   padding: EdgeInsets.only(bottom: 45),
            //                   child: Center(
            //                     child: Text("Brak danych..."),
            //                   ),
            //                 )
            //               : SizedBox(
            //                   height: 350,
            //                   child: SelectionArea(
            //                     selectionControls: EmptyTextSelectionControls(),
            //                     child: ScrollableTableView(
            //                       headers: [
            //                         "Numer projektu",
            //                         "Sztuk/słupek",
            //                         "Ilość słupków/paleta",
            //                         "Sztuk/paleta",
            //                         "Waga poj. kartonika",
            //                         "Wysokość palety",
            //                         "Waga palety",
            //                       ].map((label) {
            //                         return TableViewHeader(
            //                           width: 110,
            //                           label: label,
            //                           textStyle: const TextStyle(fontSize: 10),
            //                         );
            //                       }).toList(),
            //                       rows: model.flatOptions.map((EstimationOption option) {
            //                         return TableViewRow(height: 40, cells: [
            //                           TableViewCell(
            //                             child: Text(
            //                               option.name,
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.boxesPerOuter.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.boxesPerLayer.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.boxesPerPalette.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.cardboardBoxWeight.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.paletteHeight.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.paletteWeight.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                         ]);
            //                       }).toList(),
            //                     ),
            //                   ),
            //                 ),
            //           model.clamshellOptions.isEmpty
            //               ? const Padding(
            //                   padding: EdgeInsets.only(bottom: 45),
            //                   child: Center(
            //                     child: Text("Brak danych..."),
            //                   ),
            //                 )
            //               : SizedBox(
            //                   height: 350,
            //                   child: SelectionArea(
            //                     selectionControls: EmptyTextSelectionControls(),
            //                     child: ScrollableTableView(
            //                       headers: [
            //                         "Numer projektu",
            //                         "Sztuk/karton",
            //                         "Sztuk/warstwa",
            //                         "Sztuk/paleta",
            //                         "Waga poj. kartonika",
            //                         "Wysokość palety",
            //                         "Waga palety",
            //                       ].map((label) {
            //                         return TableViewHeader(
            //                           width: 110,
            //                           label: label,
            //                           textStyle: const TextStyle(fontSize: 10),
            //                         );
            //                       }).toList(),
            //                       rows: model.gluedOptions.map((EstimationOption option) {
            //                         return TableViewRow(height: 40, cells: [
            //                           TableViewCell(
            //                             child: Text(
            //                               option.name,
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.boxesPerOuter.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.boxesPerLayer.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.boxesPerPalette.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.cardboardBoxWeight.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.paletteHeight.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                           TableViewCell(
            //                             child: Text(
            //                               option.paletteWeight.toString(),
            //                               style: const TextStyle(fontSize: 10),
            //                             ),
            //                           ),
            //                         ]);
            //                       }).toList(),
            //                     ),
            //                   ),
            //                 ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // YaruExpansionPanel(
            //   height: double.maxFinite,
            //   headers: [
            //     Text(model.gluedOptions.isEmpty ? 'Klejone' : 'Klejone (${model.gluedOptions.length})'),
            //     Text(model.flatOptions.isEmpty ? 'Na płasko' : 'Na płasko ${model.flatOptions.length}'),
            //     Text(model.clamshellOptions.isEmpty ? "Clamshell'e" : "Clamshell'e ${model.clamshellOptions.length}"),
            //   ],
            //   children: [

            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
