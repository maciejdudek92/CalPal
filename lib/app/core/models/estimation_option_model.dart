import 'package:decimal/decimal.dart';
import 'package:palcal/app/core/models/cardboard_box_model.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';

class EstimationOption {
  String name;
  int layers;
  double height;
  List<OuterBox>? outerBoxes;
  List<CardboardBox>? flatBoxes;

  EstimationOption({required this.name, required this.layers, required this.height, this.outerBoxes, this.flatBoxes});

  get cardboardBoxWeight => () {
        if (outerBoxes != null) {
          return outerBoxes!.first.weight.toDouble();
        } else if (flatBoxes != null) {
          return flatBoxes!.first.weight.toDouble();
        } else {
          return 0.0;
        }
      };

  int get boxesPerPalette {
    return outerBoxes!.length;
  }

  int get boxesPerOuter {
    return outerBoxes!.first.cardboardBoxes!.length;
  }

  int get boxesPerLayer {
    int outersPerLayer = outerBoxes!.length ~/ layers;
    return outersPerLayer ~/ outerBoxes!.first.cardboardBoxes!.length;
  }
}
