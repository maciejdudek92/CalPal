import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:calpal/core/models/estimation_option_model.dart';
import 'package:calpal/ui/views/estimation_options/widgets/options_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'estimation_options_viewmodel.dart';

class EstimationOptionsView extends StackedView<EstimationOptionsViewModel> {
  CardboardBoxType type;
  EstimationOptionsView({Key? key, required this.type}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EstimationOptionsViewModel viewModel,
    Widget? child,
  ) {
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
  }

  @override
  EstimationOptionsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EstimationOptionsViewModel(type);
}
