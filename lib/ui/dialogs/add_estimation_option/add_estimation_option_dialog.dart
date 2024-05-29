import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:calpal/ui/dialogs/add_estimation_option/widgets/add_estimation_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:calpal/ui/common/app_colors.dart';
import 'package:calpal/ui/common/ui_helpers.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yaru/yaru.dart';

import 'add_estimation_option_dialog_model.dart';

const double _graphicSize = 60;

class AddEstimationOptionDialog
    extends StackedView<AddEstimationOptionDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddEstimationOptionDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddEstimationOptionDialogModel viewModel,
    Widget? child,
  ) {
    return AddEstimationDialogWidget(
      onClose: () {
        viewModel.gluedForm.reset();
        viewModel.flatForm.reset();
        viewModel.clamshellForm.reset();
      },
      onTabSwitch: (type) => viewModel.setBoxType(type),
      forms: [viewModel.gluedForm, viewModel.flatForm, viewModel.clamshellForm],
      addOptionTo: (option) => viewModel.addOptionFromForm(option),
    );
    // return Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   backgroundColor: Colors.white,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Expanded(
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     request.title ?? 'Hello Stacked Dialog!!',
    //                     style: const TextStyle(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.w900,
    //                     ),
    //                   ),
    //                   if (request.description != null) ...[
    //                     verticalSpaceTiny,
    //                     Text(
    //                       request.description!,
    //                       style: const TextStyle(
    //                         fontSize: 14,
    //                         color: kcMediumGrey,
    //                       ),
    //                       maxLines: 3,
    //                       softWrap: true,
    //                     ),
    //                   ],
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               width: _graphicSize,
    //               height: _graphicSize,
    //               decoration: const BoxDecoration(
    //                 color: Color(0xFFF6E7B0),
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(_graphicSize / 2),
    //                 ),
    //               ),
    //               alignment: Alignment.center,
    //               child: const Text('⭐️', style: TextStyle(fontSize: 30)),
    //             )
    //           ],
    //         ),
    //         verticalSpaceMedium,
    //         GestureDetector(
    //           onTap: () => completer(DialogResponse(confirmed: true)),
    //           child: Container(
    //             height: 50,
    //             width: double.infinity,
    //             alignment: Alignment.center,
    //             decoration: BoxDecoration(
    //               color: Colors.black,
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             child: const Text(
    //               'Got it',
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  AddEstimationOptionDialogModel viewModelBuilder(BuildContext context) =>
      AddEstimationOptionDialogModel();
}
