import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yaru/yaru.dart';

class AddEstimationDialogWidget extends StatefulWidget {
  VoidCallback onClose;
  Function(CardboardBoxType type) onTabSwitch;
  List<FormGroup> forms;
  Function(Map<String, Object?> option) addOptionTo;
  AddEstimationDialogWidget(
      {super.key,
      required this.onClose,
      required this.onTabSwitch,
      required this.forms,
      required this.addOptionTo});

  @override
  State<AddEstimationDialogWidget> createState() =>
      _AddEstimationDialogWidgetState();
}

class _AddEstimationDialogWidgetState extends State<AddEstimationDialogWidget>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  CardboardBoxType getBoxType() {
    switch (tabController!.index) {
      case 1:
        return CardboardBoxType.flat;
      case 2:
        return CardboardBoxType.clamshell;
      default:
        return CardboardBoxType.glued;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: YaruWindowControl(
              type: YaruWindowControlType.close,
              onTap: () async {
                Navigator.maybePop(context);
                widget.onClose();
              },
            ),
          ),
        ],
        title: YaruTabBar(
            tabController: tabController,
            tabs: const [
              YaruTab(
                label: 'Klejone',
              ),
              YaruTab(
                label: 'Na płasko',
              ),
              YaruTab(
                label: 'Clamshell',
              ),
            ],
            onTap: (index) {
              widget.onTabSwitch(getBoxType());
            }),
        isClosable: false,
      ),
      content: SizedBox(
        width: 600,
        height: 600,
        child: TabBarView(
          controller: tabController,
          children: widget.forms
              .map(
                (form) => ReactiveForm(
                  formGroup: form,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 450,
                        child: CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                children: [
                                  ...form.rawValue.keys.map(
                                    (e) {
                                      String? fieldLabel;
                                      List<TextInputFormatter> inputFormatters =
                                          [
                                        // FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z\W]'), replacementString: ''),
                                      ];
                                      switch (e) {
                                        case "name":
                                          fieldLabel = "Numer projektu";
                                          break;
                                        case "length":
                                          fieldLabel = "Długość kartonika";
                                          break;
                                        case "width":
                                          fieldLabel = "Szerokość kartonika";
                                          break;
                                        case "surfaceArea":
                                          fieldLabel = "Pole powierzchni";
                                          inputFormatters.add(
                                              FilteringTextInputFormatter.deny(
                                                  ',',
                                                  replacementString: '.'));
                                          break;
                                        case "grammage":
                                          fieldLabel = "Gramatura surowca";
                                          break;
                                        case "caliper":
                                          fieldLabel = "Grubość surowca";
                                          break;
                                        case "foldLayers":
                                          fieldLabel =
                                              "Ilość warstw surowca (zagięć)";
                                          break;
                                        case "maxOuterBoxWeight":
                                          fieldLabel = "Max. waga kartonu";
                                          break;
                                        case "maxPaletteHeight":
                                          fieldLabel = "Max. wysokość palety";
                                          inputFormatters.add(
                                              FilteringTextInputFormatter.deny(
                                                  ',',
                                                  replacementString: '.'));
                                          break;
                                        default:
                                          return const SizedBox.shrink();
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ReactiveTextField(
                                          formControlName: e,
                                          decoration: InputDecoration(
                                            labelText: fieldLabel,
                                          ),
                                          validationMessages: {
                                            'required': (error) =>
                                                'To pole nie może być puste!'
                                          },
                                          inputFormatters: inputFormatters,
                                          showErrors: (control) =>
                                              control.invalid && control.dirty,
                                        ),
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      50.0),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        image: AssetImage(getBoxType() ==
                                                                CardboardBoxType
                                                                    .flat
                                                            ? 'assets/images/flat_box.png'
                                                            : 'assets/images/glued_box.png'),
                                                        fit: BoxFit.fill,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                        isAntiAlias: true,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                // return Padding(
                                                //   padding: const EdgeInsets.all(25.0),
                                                //   child: SizedBox(
                                                //     width: 100,
                                                //     height: 100,
                                                //     child: ClipRRect(
                                                //       borderRadius: BorderRadius.circular(10),
                                                //       child: Stack(
                                                //         children: [
                                                //           Align(
                                                //             alignment: Alignment.center,
                                                //             child:
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            );
                                          },
                                          icon:
                                              const Icon(YaruIcons.information),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ReactiveFormConsumer(
                          builder: (context, form, child) {
                            return OutlinedButton(
                              onPressed: form.valid
                                  ? () {
                                      widget.addOptionTo(form.value);

                                      Navigator.maybePop(context);
                                    }
                                  : null,
                              child: const Text('Dodaj'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
