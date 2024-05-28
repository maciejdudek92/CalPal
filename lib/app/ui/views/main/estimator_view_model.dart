import 'package:injectable/injectable.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/glued_options_view_model.dart';
import 'package:palcal/app/ui/views/shared/view_model.dart';
import 'package:palcal/app/locator.dart';


@Injectable(order: -1)
class EstimatorViewModel extends ViewModel {
  // final List<EstimationOption> _gluedOptions = [];
  // List<EstimationOption> get gluedOptions => _gluedOptions;

  addGluedOption(EstimationOption option) {
    setBusy(true);
    locator<GluedOptionsViewModel>().addOption(option);
    setBusy(false);
  }

  // final List<EstimationOption> _flatOptions = [];
  // List<EstimationOption> get flatOptions => _flatOptions;

  addFlatOption(EstimationOption option) {
    setBusy(true);
    locator<GluedOptionsViewModel>().addOption(option);

    setBusy(false);
  }

  // final List<EstimationOption> _clamshellOptions = [];
  // List<EstimationOption> get clamshellOptions => _clamshellOptions;
  addClamshellOption(EstimationOption option) {
    setBusy(true);
    locator<GluedOptionsViewModel>().addOption(option);

    setBusy(false);
  }
}
