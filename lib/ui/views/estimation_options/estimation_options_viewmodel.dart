import 'package:calpal/app/app.locator.dart';
import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:calpal/core/models/estimation_option_model.dart';
import 'package:calpal/services/estimator_service.dart';
import 'package:stacked/stacked.dart';

class EstimationOptionsViewModel extends BaseViewModel {
  // final List<EstimationOption> _options;
  final _estimatorService = locator<EstimatorService>();
  final CardboardBoxType _type;
  get type => _type;
  EstimationOptionsViewModel(this._type);
  List<EstimationOption> get options => _estimatorService.getOptions(_type);
  bool selectAllOptions = false;

  setSelectOption(EstimationOption option, bool value) {
    option.isSelected = value;
    rebuildUi();
  }

  setSelectAllOptions(bool value) {
    selectAllOptions = value;
    for (final option in _estimatorService.getOptions(_type)) {
      option.isSelected = value;
    }
    rebuildUi();
  }

  addOption(EstimationOption option) {
    _estimatorService.addOption(_type, option);
    setSelectAllOptions(false);
  }

  removeOption(EstimationOption option) {
    _estimatorService.removeOption(_type, option);
    rebuildUi();
  }
}
