import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart' hide View;
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/glued_options_view_model.dart';
import 'package:palcal/app/ui/views/shared/base_view.dart';
import 'package:palcal/app/ui/widgets/options_table_widget.dart';
import 'package:yaru/yaru.dart';

class GluedOptionsView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ViewAAA<GluedOptionsViewModel>(
      onModelReady: (viewModel) {},
      onModelDispose: (viewModel) {},
      builder: (context, viewModel, _) {
        return Center(
          child: viewModel.options.isEmpty
              ? const Text("Brak danych...")
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: OptionsTable(
                    options: viewModel.options,
                    isAllOptionsSelected: viewModel.selectAllOptions,
                    onHeaderRowSelect: (bool value) {
                      viewModel.setSelectAllOptions(value);
                    },
                    onSetSelectOption: (option, value) {
                      viewModel.setSelectOption(option, value);
                    },
                  ),
                ),
        );
      },
    );
  }
}

// class GluedOptionsView extends BaseView<GluedOptionsViewModel> {
//   GluedOptionsView({super.key});

//   @override
//   void initState(_, viewModel) {}

//   @override
//   void dispose() {}

//   @override
//   Widget build(BuildContext context, GluedOptionsViewModel model, Widget? child) {
//     return Center(
//       child: model.options.isEmpty
//           ? const Text("Brak danych...")
//           : Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: OptionsTable(
//                 options: model.options,
//                 isAllOptionsSelected: model.selectAllOptions,
//                 onHeaderRowSelect: (bool value) {
//                   model.setSelectAllOptions(value);
//                 },
//                 onSetSelectOption: (option, value) {
//                   model.setSelectOption(option, value);
//                 },
//               ),
//             ),
//     );
//   }
// }
