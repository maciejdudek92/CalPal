import 'package:palcal/app/core/enums/view_state.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/view_model.dart';

class EstimatorViewModel extends ViewModel {
  final List<OuterBox> outerBoxesOptions = [
    OuterBox(length: 385, width: 385),
    OuterBox(length: 385, width: 285),
    OuterBox(length: 385, width: 250),
    OuterBox(length: 385, width: 225),
  ];

  final List<EstimationOption> _gluedOptions = [];
  List<EstimationOption> get gluedOptions => _gluedOptions;

  addGluedOption(EstimationOption option) {
    setState(ViewState.busy);
    _gluedOptions.add(option);
    setState(ViewState.busy);
  }

  final List<EstimationOption> _flatOptions = [];
  List<EstimationOption> get flatOptions => _flatOptions;
  addFlatOption(EstimationOption option) {
    setState(ViewState.busy);
    _flatOptions.add(option);
    setState(ViewState.busy);
  }

  final List<EstimationOption> _clamshellOptions = [];
  List<EstimationOption> get clamshellOptions => _clamshellOptions;
  addClamshellOption(EstimationOption option) {
    setState(ViewState.busy);
    _clamshellOptions.add(option);
    setState(ViewState.busy);
  }
}

// 385x385 [3x2] -> OK
// 385x285 [2x4] -> OK
// 385x250 [3x3] -> OK
// 385x225 [5x2] -> OK
