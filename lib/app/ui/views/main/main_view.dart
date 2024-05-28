import 'package:flutter/material.dart' hide View;
import 'package:palcal/app/ui/views/main/estimator_view_model.dart';
import 'package:palcal/app/ui/views/shared/base_view.dart';
import 'package:palcal/app/ui/views/estimator_form/estimator_form_view.dart';
import 'package:palcal/app/ui/views/glued_options_view.dart';
import 'package:palcal/app/ui/views/main/widgets/estimation_options_widget.dart';
import 'package:yaru/yaru.dart';
import 'dart:io';

// class MainPage extends View<EstimatorViewModel> {
//   MainPage({super.key}) : super();

//   @override
//   void initState(EstimatorViewModel viewModel) {
//     // TODO: implement initState
//   }

//   @override
//   Widget build(BuildContext context, EstimatorViewModel viewModel, Widget? _) {
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
//         title: const Text("Cal-Pal"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: YaruWindowControl(
//               type: YaruWindowControlType.close,
//               onTap: () async {
//                 exit(0);
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         onPressed: ()
//             // {
//             //   EstimationOption option = EstimationOption(
//             //     name: "12345_1",
//             //     layers: 10,
//             //     height: 150,
//             //     outerBoxes: [],
//             //     flatCardboardBoxes: [],
//             //   );
//             //   model.addGluedOption(option);
//             // },
//             =>
//             showDialog(
//           barrierDismissible: true,
//           context: context,
//           builder: (context) {
//             return EstimatorFormView();
//           },
//         ),
//         child: const Icon(YaruIcons.plus),
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(kYaruPagePadding),
//           child: EstimationOptionsWidget(
//             tabs: [
//               EstimationOptionsTab(label: 'Klejone', child: GluedOptionsView()),
//               EstimationOptionsTab(label: 'Na płasko', child: GluedOptionsView()),
//               EstimationOptionsTab(label: "Clamshell'e", child: GluedOptionsView()),
//             ],
//           )),
//     );
//   }
// }

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewAAA<EstimatorViewModel>(
      // onModelReady: (viewModel) {},
      // onModelDispose: (viewModel) {},
      builder: (context, viewModel, _) {
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
              child: EstimationOptionsWidget(
                tabs: [
                  EstimationOptionsTab(label: 'Klejone', child: GluedOptionsView()),
                  EstimationOptionsTab(label: 'Na płasko', child: GluedOptionsView()),
                  EstimationOptionsTab(label: "Clamshell'e", child: GluedOptionsView()),
                ],
              )),
        );
      },
    );
  }
}
