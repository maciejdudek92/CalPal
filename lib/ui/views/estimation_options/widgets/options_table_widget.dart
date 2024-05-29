import 'package:calpal/core/models/estimation_option_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart' hide View;
import 'package:yaru/yaru.dart';

class OptionsTable extends StatelessWidget {
  List<EstimationOption> options;
  Function(bool value) onHeaderRowSelect;
  Function(EstimationOption option, bool value) onSetSelectOption;
  bool isAllOptionsSelected;
  OptionsTable(
      {super.key,
      required this.options,
      required this.onHeaderRowSelect,
      required this.onSetSelectOption,
      this.isAllOptionsSelected = false});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      selectionControls: EmptyTextSelectionControls(),
      child: DataTable2(
        // controller: tableController,
        columnSpacing: 6,
        horizontalMargin: 12,
        columns: [
          DataColumn2(
            // fixedWidth: 60,
            label: Center(
              child: YaruCheckbox(
                value: isAllOptionsSelected,
                onChanged: (value) {
                  onHeaderRowSelect(value!);
                },
              ),
            ),
          ),
          ...[
            "Nazwa\nprojektu",
            "Sztuk\n/karton",
            "Sztuk\n/warstwa",
            "Sztuk\n/paleta",
            "Waga poj.\nkartonika",
            "Wysokość\npalety",
            "Waga\npalety",
            "Szczegóły",
          ].map((label) {
            return DataColumn2(
              // fixedWidth: 60,
              label: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            );
          }),
        ],
        rows: options.map((EstimationOption option) {
          return DataRow(
            cells: [
              DataCell(
                Center(
                  child: YaruCheckbox(
                    value: option.isSelected,
                    onChanged: (value) {
                      onSetSelectOption(option, value!);
                    },
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    option.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    option.boxesPerOuter.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    option.boxesPerLayer.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    option.boxesPerPalette.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    "${option.cardboardBoxWeight.toStringAsFixed(2)}g",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    "${option.paletteHeight.toString()}m",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    "ok. ${option.paletteWeight.toString()}kg",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: IconButton(
                    onPressed: () async => showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 500,
                          child: AlertDialog(
                            titlePadding: EdgeInsets.zero,
                            title: YaruDialogTitleBar(
                              title: Text(option.name),
                              isClosable: false,
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: YaruWindowControl(
                                    type: YaruWindowControlType.close,
                                    onTap: () async {
                                      Navigator.maybePop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            content: SizedBox(
                              height: 400,
                              child: YaruBanner.tile(
                                surfaceTintColor: Colors.pink,
                                title: Text(
                                  'Wymiar kartonu',
                                ),
                                subtitle: Text(
                                  "${option.outerBoxes!.first.length}x${option.outerBoxes!.first.width}x${option.outerBoxes!.first.height}",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
