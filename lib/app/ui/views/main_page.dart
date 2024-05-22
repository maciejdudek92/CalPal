import 'package:flutter/material.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';
import 'package:palcal/app/ui/shared/base_view.dart';
import 'package:palcal/app/ui/views/estimator_form_view.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yaru/yaru.dart';
import 'dart:io';
import 'package:scrollable_table_view/scrollable_table_view.dart';

class MainPage extends BaseView<EstimatorViewModel> {
  const MainPage({super.key});

  @override
  void initState(state, viewModel) {}
  @override
  void dispose() {}

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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          EstimationOption option = EstimationOption(
            name: "12345_1",
            layers: 10,
            height: 150,
            outerBoxes: [],
            flatCardboardBoxes: [],
          );
          model.addGluedOption(option);
        },
        // => showDialog(
        //   barrierDismissible: true,
        //   context: context,
        //   builder: (context) {
        //     return EstimatorFormView();
        //   },
        // ),
        child: const Icon(YaruIcons.plus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kYaruPagePadding),
        child: YaruExpansionPanel(
          headers: [
            Text(model.gluedOptions.isEmpty ? 'Klejone' : 'Klejone (${model.gluedOptions.length})'),
            Text(model.flatOptions.isEmpty ? 'Na płasko' : 'Na płasko ${model.flatOptions.length}'),
            Text(model.clamshellOptions.isEmpty ? "Clamshell'e" : "Clamshell'e ${model.clamshellOptions.length}"),
          ],
          children: [
            model.gluedOptions.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 45),
                    child: Center(
                      child: Text("Brak danych..."),
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
                          return TableViewRow(height: 40, cells: [
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
                    padding: EdgeInsets.only(bottom: 45),
                    child: Center(
                      child: Text("Brak danych..."),
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
                          return TableViewRow(height: 40, cells: [
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
                    padding: EdgeInsets.only(bottom: 45),
                    child: Center(
                      child: Text("Brak danych..."),
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
                          return TableViewRow(height: 40, cells: [
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
