import 'package:palcal/app/core/models/outer_box_model.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/view_model.dart';

class EstimatorViewModel extends ViewModel {


  final List<EstimationOption> _gluedOptions = [];
  List<EstimationOption> get gluedOptions => _gluedOptions;

  addGluedOption(EstimationOption option) {
    setBusy(true);
    _gluedOptions.add(option);
    setBusy(false);
  }

  final List<EstimationOption> _flatOptions = [];
  List<EstimationOption> get flatOptions => _flatOptions;

  addFlatOption(EstimationOption option) {
    setBusy(true);
    _flatOptions.add(option);
    setBusy(false);
  }

  final List<EstimationOption> _clamshellOptions = [];
  List<EstimationOption> get clamshellOptions => _clamshellOptions;
  addClamshellOption(EstimationOption option) {
    setBusy(true);
    _clamshellOptions.add(option);
    setBusy(false);
  }
}
