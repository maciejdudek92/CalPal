import 'dart:io';

import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:calpal/ui/dialogs/add_estimation_option/add_estimation_option_dialog.dart';
import 'package:calpal/ui/views/estimation_options/estimation_options_view.dart';
import 'package:calpal/ui/views/home/widgets/estimation_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:calpal/ui/common/app_colors.dart';
import 'package:calpal/ui/common/ui_helpers.dart';
import 'package:yaru/yaru.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        onPressed: () => viewModel.showDialog().then((value) => viewModel.rebuildUi()),

        // ()
        //     // {
        //     //   EstimationOption option = EstimationOption(
        //     //     name: "12345_1",
        //     //     layers: 10,
        //     //     height: 150,
        //     //     outerBoxes: [],
        //     //     flatCardboardBoxes: [],
        //     //   );
        //     //   model.addGluedOption(option);
        //     // },
        //     =>
        //     showDialog(
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
        child: EstimationOptionsWidget(
          tabs: [
            EstimationOptionsTab(
                label: 'Klejone',
                child: EstimationOptionsView(
                  type: CardboardBoxType.glued,
                )),
            EstimationOptionsTab(
                label: 'Na płasko',
                child: EstimationOptionsView(
                  type: CardboardBoxType.flat,
                )),
            EstimationOptionsTab(
                label: "Clamshell'e",
                child: EstimationOptionsView(
                  type: CardboardBoxType.clamshell,
                )),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
