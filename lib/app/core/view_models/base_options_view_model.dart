import 'package:palcal/app/core/enums/cardbox_type.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/ui/views/shared/view_model.dart';


class BaseOptionsViewModel extends ViewModel {
  List<EstimationOption> _options = [];
  List<EstimationOption> get options => _options;
  bool selectAllOptions = false;

  setOptions(List<EstimationOption> options) {
    _options = options;
  }

  setSelectOption(EstimationOption option, bool value) {
    setBusy(true);
    option.isSelected = value;
    setBusy(false);
  }

  setSelectAllOptions(bool value) {
    setBusy(true);
    selectAllOptions = value;
    for (final option in _options) {
      option.isSelected = value;
    }
    setBusy(false);
  }

  addOption(EstimationOption option) {
    setBusy(true);
    _options.add(option);
    setSelectAllOptions(false);
  }

  removeOption(EstimationOption option) {
    setBusy(true);
    _options.remove(option);
    setBusy(false);
  }
}
