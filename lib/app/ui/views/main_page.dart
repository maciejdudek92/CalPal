import 'package:flutter/material.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () => showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.maybePop(context),
                  child: Text(
                    'Evil Force-Close',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
              titlePadding: EdgeInsets.zero,
              title: YaruDialogTitleBar(
                leading: const Center(
                  child: SizedBox.square(
                    dimension: 25,
                    child: YaruCircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                ),
                title: const Text('The Title'),
                isClosable: true,
              ),
              content: SizedBox(
                height: 100,
                child: YaruBanner.tile(
                  surfaceTintColor: Colors.pink,
                  title: Text(
                    'You cannot close me',
                  ),
                  subtitle: Text(
                    'No way',
                  ),
                  icon: Text(
                    '💅',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          },
        ),
        child: const Icon(YaruIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: YaruExpansionPanel(
          headers: [
            Text(model.clamshellOptions.isEmpty ? 'Klejone' : 'Klejone (${model.clamshellOptions.length})'),
            Text(model.flatOptions.isEmpty ? 'Na płasko' : 'Na płasko ${model.flatOptions.length}'),
            Text(model.clamshellOptions.isEmpty ? "Clamshell'e" : "Clamshell'e ${model.clamshellOptions.length}"),
          ],
          children: [
            model.gluedOptions.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Center(
                      child: Text("Brak..."),
                    ),
                  )
                : SizedBox(
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
                          "Wysokość palety",
                          "Waga palety",
                        ].map((label) {
                          return TableViewHeader(
                            width: 110,
                            label: label,
                            textStyle: const TextStyle(fontSize: 10),
                          );
                        }).toList(),
                        rows: model.gluedOptions.map((EstimationOption option) {
                          return TableViewRow(height: 60, cells: [
                            TableViewCell(
                              child: Text(
                                option.name,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerOuter.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerLayer.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerPalette.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.cardboardBoxWeight.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
            model.flatOptions.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Center(
                      child: Text("Brak..."),
                    ),
                  )
                : SizedBox(
                    height: 350,
                    child: SelectionArea(
                      selectionControls: EmptyTextSelectionControls(),
                      child: ScrollableTableView(
                        headers: [
                          "Numer projektu",
                          "Sztuk/słupek",
                          "Ilość słupków/paleta",
                          "Sztuk/paleta",
                          "Waga poj. kartonika",
                          "Wysokość palety",
                          "Waga palety",
                        ].map((label) {
                          return TableViewHeader(
                            width: 110,
                            label: label,
                            textStyle: const TextStyle(fontSize: 10),
                          );
                        }).toList(),
                        rows: model.gluedOptions.map((EstimationOption option) {
                          return TableViewRow(height: 60, cells: [
                            TableViewCell(
                              child: Text(
                                option.name,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerOuter.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerLayer.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerPalette.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.cardboardBoxWeight.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
            model.clamshellOptions.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Center(
                      child: Text("Brak..."),
                    ),
                  )
                : SizedBox(
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
                          "Wysokość palety",
                          "Waga palety",
                        ].map((label) {
                          return TableViewHeader(
                            width: 110,
                            label: label,
                            textStyle: const TextStyle(fontSize: 10),
                          );
                        }).toList(),
                        rows: model.gluedOptions.map((EstimationOption option) {
                          return TableViewRow(height: 60, cells: [
                            TableViewCell(
                              child: Text(
                                option.name,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerOuter.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerLayer.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.boxesPerPalette.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                            TableViewCell(
                              child: Text(
                                option.cardboardBoxWeight.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
