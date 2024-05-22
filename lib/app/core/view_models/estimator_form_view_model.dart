import 'package:palcal/app/core/enums/cardbox_type.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';
import 'package:palcal/app/core/view_models/view_model.dart';
import 'package:palcal/app/locator.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EstimatorFormViewModel extends ViewModel {
  CardboardBoxType? _boxType;
  CardboardBoxType? get boxType => _boxType;
  setBoxType() {
    setBusy(true);
    _boxType = flatAndGluedForm.value["boxType"] as CardboardBoxType;
    setBusy(false);
  }

  final flatAndGluedForm = FormGroup({
    'boxType': FormControl<CardboardBoxType>(validators: [Validators.required]),
    'length': FormControl<int>(validators: [Validators.required]),
    'width': FormControl<int>(validators: [Validators.required]),
    'surfaceArea': FormControl<double>(validators: [Validators.required]),
    'grammage': FormControl<int>(validators: [Validators.required]),
    'caliper': FormControl<int>(validators: [Validators.required]),
    'foldLayers': FormControl<int>(validators: [Validators.required]),
    'maxPaletteHeight': FormControl<double>(value: 1.65, validators: [Validators.required]),
  });

  final clamshellForm = FormGroup({
    'length': FormControl<int>(validators: [Validators.required]),
    'width': FormControl<int>(validators: [Validators.required]),
    'height': FormControl<int>(validators: [Validators.required]),
    'pressedHeight': FormControl<int>(validators: [Validators.required]),
    'surfaceArea': FormControl<double>(validators: [Validators.required]),
    'grammage': FormControl<int>(validators: [Validators.required]),
    'maxPaletteHeight': FormControl<double>(value: 1.65, validators: [Validators.required]),
  });

  Future<void> addOptionFromForm(Map<String, Object?> formData) async {
    EstimatorViewModel _estimator_view_model = locator.get<EstimatorViewModel>();

    EstimationOption option = EstimationOption(
      name: "12345_1",
      layers: 10,
      height: 150,
      outerBoxes: [],
      flatCardboardBoxes: [],
    );

    if (_boxType == CardboardBoxType.glued) {
      _estimator_view_model.addGluedOption(option);
    } else if (_boxType == CardboardBoxType.flat) {
      _estimator_view_model.addFlatOption(option);
    } else if (_boxType == CardboardBoxType.clamshell) {
      _estimator_view_model.addClamshellOption(option);
    } else {
      throw Exception("Nie można dodać, błędny typ");
    }
  }
}
