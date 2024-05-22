import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:palcal/app/core/enums/cardbox_type.dart';
import 'package:palcal/app/core/view_models/estimator_form_view_model.dart';
import 'package:palcal/app/ui/shared/base_view.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yaru/yaru.dart';

class EstimatorFormView extends BaseView<EstimatorFormViewModel> {
  EstimatorFormView() : super(stateMixins: StateMixins.withTicketProvider);
  late TabController tabController;

  @override
  void initState(state, viewModel) {
    tabController = TabController(length: 2, vsync: state);
  }

  @override
  void dispose() {
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context, EstimatorFormViewModel model, Widget? child) {
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
                model.flatAndGluedForm.reset();
                model.clamshellForm.reset();
              },
            ),
          ),
        ],
        title: YaruTabBar(
          tabController: tabController,
          tabs: const [
            YaruTab(
              label: 'Klejone/Na płasko',
            ),
            YaruTab(
              label: 'Clamshell',
            ),
          ],
        ),
        isClosable: false,
      ),
      content: SizedBox(
        width: 600,
        height: 400,
        child: TabBarView(
          controller: tabController,
          children: [
            Column(
              children: [
                ReactiveForm(
                  formGroup: model.flatAndGluedForm,
                  child: SizedBox(
                    height: 400,
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ReactiveDropdownField(
                                  decoration: InputDecoration(
                                    labelText: "Rodzaj",
                                  ),
                                  formControlName: "boxType",
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        "Klejony",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      value: CardboardBoxType.glued,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Na płasko",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      value: CardboardBoxType.flat,
                                    )
                                  ],
                                  onChanged: (control) {
                                    model.setBoxType();
                                  },
                                ),
                              ),
                              ...model.flatAndGluedForm.rawValue.keys.map(
                                (e) {
                                  String? fieldLabel;
                                  List<TextInputFormatter> inputFormatters = [
                                    FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z\W]'), replacementString: ''),
                                  ];
                                  switch (e) {
                                    case "length":
                                      fieldLabel = "Długość kartonika";
                                      break;
                                    case "width":
                                      fieldLabel = "Szerokość kartonika";
                                      break;
                                    case "surfaceArea":
                                      fieldLabel = "Pole powierzchni";
                                      inputFormatters.add(FilteringTextInputFormatter.deny(',', replacementString: '.'));
                                      break;
                                    case "grammage":
                                      fieldLabel = "Gramatura surowca";
                                      break;
                                    case "caliper":
                                      fieldLabel = "Grubość surowca";
                                      break;
                                    case "foldLayers":
                                      fieldLabel = "Ilość warstw surowca (zagięć)";
                                      break;
                                    case "maxPaletteHeight":
                                      fieldLabel = "Max. wysokość palety";
                                      inputFormatters.add(FilteringTextInputFormatter.deny(',', replacementString: '.'));
                                      break;
                                    default:
                                      return SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ReactiveTextField(
                                      formControlName: e,
                                      decoration: InputDecoration(
                                        labelText: fieldLabel,
                                      ),
                                      validationMessages: {'required': (error) => 'To pole nie może być puste!'},
                                      inputFormatters: inputFormatters,
                                      showErrors: (control) => control.invalid && control.dirty,
                                    ),
                                  );
                                },
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: model.boxType == null
                                          ? null
                                          : () async {
                                              await showDialog(
                                                barrierDismissible: true,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(50.0),
                                                    child: Align(
                                                      alignment: Alignment.center,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image(
                                                          image: AssetImage(model.boxType == CardboardBoxType.flat ? 'assets/images/flat_box.png' : 'assets/images/glued_box.png'),
                                                          fit: BoxFit.fill,
                                                          filterQuality: FilterQuality.high,
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
                                      icon: Icon(YaruIcons.information),
                                    ),
                                    Spacer(),
                                    ReactiveFormConsumer(
                                      builder: (context, form, child) {
                                        return OutlinedButton(
                                          child: Text('Dodaj'),
                                          onPressed: form.valid
                                              ? () {
                                                  model.addOptionFromForm(form.value);
                                                  Navigator.maybePop(context);
                                                }
                                              : null,
                                        );
                                      },
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
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  // height: 100,
                  child: ReactiveForm(
                    formGroup: model.flatAndGluedForm,
                    child: Column(
                      children: <Widget>[
                        ReactiveTextField(
                          formControlName: 'length',
                        ),
                        ReactiveTextField(
                          formControlName: 'width',
                        ),
                        ReactiveTextField(
                          formControlName: 'surfaceArea',
                        ),
                        ReactiveTextField(
                          formControlName: 'grammage',
                        ),
                        ReactiveTextField(
                          formControlName: 'caliper',
                        ),
                        ReactiveTextField(
                          formControlName: 'maxPaletteHeight',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
