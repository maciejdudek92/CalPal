import 'package:decimal/decimal.dart';
import 'package:palcal/app/core/enums/cardbox_type.dart';
import 'package:palcal/app/core/models/cardboard_box_model.dart';
import 'package:palcal/app/core/models/estimation_option_model.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';
import 'package:palcal/app/core/view_models/view_model.dart';
import 'package:palcal/app/locator.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EstimatorFormViewModel extends ViewModel {
  CardboardBoxType? _boxType = CardboardBoxType.glued;
  CardboardBoxType? get boxType => _boxType;
  setBoxType() {
    setBusy(true);
    _boxType = flatAndGluedForm.value["boxType"] as CardboardBoxType;
    setBusy(false);
  }

  final List<OuterBox> outerBoxOptions = [
    OuterBox(length: 385, width: 385, height: 0),
    OuterBox(length: 385, width: 285, height: 0),
    OuterBox(length: 385, width: 250, height: 0),
    OuterBox(length: 385, width: 225, height: 0),
  ];

  final flatAndGluedForm = FormGroup({
    'name': FormControl<String>(value: "12345", validators: [Validators.required]),
    'boxType': FormControl<CardboardBoxType>(value: CardboardBoxType.glued, validators: [Validators.required]),
    'length': FormControl<int>(value: 300, validators: [Validators.required]),
    'width': FormControl<int>(value: 104, validators: [Validators.required]),
    'surfaceArea': FormControl<double>(value: 446.22, validators: [Validators.required]),
    'grammage': FormControl<int>(value: 205, validators: [Validators.required]),
    'caliper': FormControl<double>(value: 0.35, validators: [Validators.required]),
    'foldLayers': FormControl<int>(value: 3, validators: [Validators.required]),
    'maxPaletteHeight': FormControl<double>(value: 1.65, validators: [Validators.required]),
    'maxOuterBoxWeight': FormControl<int>(value: 12, validators: [Validators.required]),
  });

  final clamshellForm = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'length': FormControl<int>(validators: [Validators.required]),
    'width': FormControl<int>(validators: [Validators.required]),
    'height': FormControl<int>(validators: [Validators.required]),
    'pressedHeight': FormControl<int>(validators: [Validators.required]),
    'surfaceArea': FormControl<double>(validators: [Validators.required]),
    'grammage': FormControl<int>(validators: [Validators.required]),
    'maxPaletteHeight': FormControl<double>(value: 1.65, validators: [Validators.required]),
    'maxOuterBoxWeight': FormControl<int>(value: 12, validators: [Validators.required]),
  });

  Future<void> addOptionFromForm(Map<String, Object?> formData) async {
    EstimatorViewModel estimator_view_model = locator.get<EstimatorViewModel>();

    CardboardBox cardboardBox = CardboardBox(
      type: _boxType!,
      length: formData["length"] as int,
      width: formData["width"] as int,
      surfaceArea: formData["surfaceArea"] as double,
      caliper: formData["caliper"] as double,
      grammage: formData["grammage"] as int,
      foldLayers: formData["foldLayers"] as int,
    );

    int maxOuterBoxWeight = (formData["maxOuterBoxWeight"] as int) * 1000;

    Decimal availablePaletteHeight = (Decimal.parse(formData["maxPaletteHeight"].toString()) - Decimal.parse("0.25")) * Decimal.fromInt(1000);

    // int cardboardBoxLength = (formData["length"] as int);
    // int cardboardBoxHeight = (formData["width"] as int);

    int rows = (385 / cardboardBox.width).round();
    if (rows == 0) rows = 1;
    int columns = (385 / cardboardBox.length).round();
    if (columns == 0) columns = 1;

    int requiredOuterWidth = (Decimal.fromInt(cardboardBox.length) * Decimal.parse(columns.toString())).toDouble().round();
    int requiredOuterHeight = (Decimal.fromInt(cardboardBox.width) * Decimal.parse(rows.toString())).toDouble().round();

    Decimal cardboardBoxGrammage = Decimal.parse(cardboardBox.grammage.toString()) + Decimal.parse(cardboardBox.surfaceArea.toString());
    double cardboardBoxThickness = _getCardboardBoxThickness(caliper: cardboardBox.caliper, foldLayers: cardboardBox.foldLayers);

    List<OuterBox> outerBoxesOptions = _getOuterBoxOptions(
      maxWeight: maxOuterBoxWeight,
      requiredWidth: requiredOuterWidth,
      requiredHeight: requiredOuterHeight,
      boxGrammage: cardboardBoxGrammage,
      boxThickness: cardboardBoxThickness,
      cardboardBox: cardboardBox,
      rows: rows,
      columns: columns,
    );

    OuterBox outerBox = outerBoxesOptions.reduce((curr, next) => curr.weight > next.weight ? curr : next);

    int layers = (availablePaletteHeight.toDouble() / outerBox.height).round();

    int boxesPerLayer = _getBoxesPerLayer(outerBox: outerBox);

    final outerBoxes = List.generate(boxesPerLayer * layers, (index) => outerBox);
    // print("options legnth");
    // print(outerBoxes.length); // = 0
    // print(boxesPerLayer); //to jest
    // print(layers); // =0

    EstimationOption option = EstimationOption(
      name: formData["name"] as String,
      layers: layers,
      height: ((layers * outerBox.height) + 25).roundToDouble(),
      outerBoxes: outerBoxes,
      flatCardboardBoxes: null,
    );

    if (_boxType == CardboardBoxType.glued) {
      estimator_view_model.addGluedOption(option);
    } else if (_boxType == CardboardBoxType.flat) {
      estimator_view_model.addFlatOption(option);
    } else if (_boxType == CardboardBoxType.clamshell) {
      estimator_view_model.addClamshellOption(option);
    } else {
      throw Exception("Nie można dodać, błędny typ");
    }
  }

  List<OuterBox> _getOuterBoxOptions({
    required int maxWeight,
    required int requiredWidth,
    required int requiredHeight,
    required Decimal boxGrammage,
    required double boxThickness,
    required CardboardBox cardboardBox,
    // required int cardboardBoxCount,
    required int rows,
    required int columns,
  }) {
    // throw Exception("");

    int boxHeight = (((requiredWidth + 4) ~/ 5) * 5) + 10;
    List<OuterBox> outerBoxes = [];

    for (OuterBox option in outerBoxOptions) {
      if (option.width - requiredWidth < 50 && option.width - requiredWidth > 0) {
        int cardboardBoxesCount = ((option.length / boxThickness).round() * rows) * columns;
        final cardboardBoxes = List.generate(cardboardBoxesCount, (index) => cardboardBox);
        OuterBox _outerBox = OuterBox(width: option.width, length: option.length, height: boxHeight, cardboardBoxes: cardboardBoxes);
        if (_outerBox.weight <= maxWeight - 500) {
          outerBoxes.add(_outerBox);
        }
        //  else {
        //   int _rows = rows > 1 ? rows - 1 : rows;
        //   int _columns = columns > 1 ? columns - 1 : columns;
        //   List<OuterBox> outerBoxesOptions = _getOuterBoxOptions(
        //     maxWeight: maxWeight,
        //     requiredWidth: requiredWidth,
        //     requiredHeight: requiredHeight,
        //     boxGrammage: boxGrammage,
        //     boxThickness: boxThickness,
        //     cardboardBox: cardboardBox,
        //     rows: _rows,
        //     columns: _columns,
        //   );
        //   if (outerBoxesOptions.isNotEmpty) return outerBoxesOptions;
        // }
      }
    }

    if (requiredWidth < 385) {
      int boxWidth = (((requiredWidth + 4) ~/ 5) * 5) + 10;
      int boxLength = (1200 - (boxWidth - 10)) ~/ 2;
      // _getBoxesPerLayer(outerBox: OuterBox(length: boxLength, width: boxWidth, height: boxHeight));
      // _getBoxesPerOuter(outerBox: OuterBox(length: boxLength, width: boxWidth, height: boxHeight), boxThickness: boxThickness);

      int cardboardBoxesCount = ((boxLength / boxThickness).round() * rows) * columns;
      final cardboardBoxes = List.generate(cardboardBoxesCount, (index) => cardboardBox);

      OuterBox _outerBox = OuterBox(
        length: boxLength,
        width: boxWidth,
        height: 0,
        cardboardBoxes: cardboardBoxes,
      );
      if (_outerBox.weight <= maxWeight - 500) {
        outerBoxes.add(_outerBox);
      }
      // else {
      //   int _rows = rows > 1 ? rows - 1 : rows;
      //   int _columns = columns > 1 ? columns - 1 : columns;
      //   List<OuterBox> outerBoxesOptions = _getOuterBoxOptions(
      //     maxWeight: maxWeight,
      //     requiredWidth: requiredWidth,
      //     requiredHeight: requiredHeight,
      //     boxGrammage: boxGrammage,
      //     boxThickness: boxThickness,
      //     cardboardBox: cardboardBox,
      //     rows: _rows,
      //     columns: _columns,
      //   );

      //   if (outerBoxesOptions.isNotEmpty) return outerBoxesOptions;
      // }
    } else {
      int boxWidth = (((requiredWidth + 4) ~/ 5) * 5) + 10;
      int boxLength = (1200 - (boxWidth - 10)) ~/ 2;
    }

    if (outerBoxes.isEmpty) {
      throw Exception("Nie udało się obliczyć paletyzacji kalkulacyjnej dla wybrenego kartonika.\n Spróbuj podać inne parametry.");
    }
    return outerBoxes;
  }

  double _getCardboardBoxThickness({required double caliper, required int foldLayers}) {
    return ((caliper * foldLayers) * 1.35);
  }

  int _getBoxesPerLayer({required OuterBox outerBox}) {
    List<int> options = [
      (1200 / outerBox.length).round() + (800 / outerBox.width).round(),
      (1200 / outerBox.width).round() + (800 / outerBox.length).round(),
    ];

    return options.reduce((curr, next) => curr > next ? curr : next);
  }

  // int _getBoxesPerOuter({required OuterBox outerBox, required double boxThickness}) {
  //   return 0;
  // }
}
