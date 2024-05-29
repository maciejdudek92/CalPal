import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:calpal/core/models/estimation_option_model.dart';

class EstimatorService {
  List<EstimationOption> _gluedOptions = [];
  List<EstimationOption> _flatOptions = [];
  List<EstimationOption> _clamshellOptions = [];

  // List<EstimationOption> get options => _gluedOptions;
  List<EstimationOption> getOptions(CardboardBoxType type) {
    switch (type) {
      case CardboardBoxType.glued:
        return _gluedOptions;
      case CardboardBoxType.flat:
        return _flatOptions;
      case CardboardBoxType.clamshell:
        return _clamshellOptions;
      default:
        return [];
    }
  }

  void addOption(CardboardBoxType type, EstimationOption option) {
    switch (type) {
      case CardboardBoxType.glued:
        _gluedOptions.add(option);
        break;
      case CardboardBoxType.flat:
        _flatOptions.add(option);
        break;
      case CardboardBoxType.clamshell:
        _clamshellOptions.add(option);
        break;
      default:
        break;
    }
  }

  void removeOption(CardboardBoxType type, EstimationOption option) {
    switch (type) {
      case CardboardBoxType.glued:
        _gluedOptions.remove(option);
        break;
      case CardboardBoxType.flat:
        _flatOptions.remove(option);
        break;
      case CardboardBoxType.clamshell:
        _clamshellOptions.remove(option);
        break;
      default:
        break;
    }
  }
}
