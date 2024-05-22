import 'package:palcal/app/core/models/cardboard_box_model.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';

class EstimationOption {
  String name;
  int layers;
  double height;
  List<OuterBox>? outerBoxes;
  List<CardboardBox>? flatCardboardBoxes;

  EstimationOption({required this.name, required this.layers, required this.height, this.outerBoxes, this.flatCardboardBoxes});

  get cardboardBoxWeight => () {
        if (outerBoxes != null) {
          return outerBoxes!.first.weight.toDouble();
        } else if (flatCardboardBoxes != null) {
          return flatCardboardBoxes!.first.weight.toDouble();
        } else {
          return 0.0;
        }
      };

  int get boxesPerPalette {
    return outerBoxes!.length;
  }

  int get boxesPerOuter {
    return 0;
    // return outerBoxes!.first.cardboardBoxes!.length;
  }

  int get boxesPerLayer {
    return 0;

    // int outersPerLayer = outerBoxes!.length ~/ layers;
    // return outersPerLayer ~/ outerBoxes!.first.cardboardBoxes!.length;
  }

  double get paletteHeight {
    return 0;
    // int boxHeight = outerBoxes!.first.height! + 15;
    // double paletteHeight = (boxHeight * layers) + 25;
    // return paletteHeight;
  }

  // factory EstimationOption.fromJson(Map<String, Object?> json) => {

  //   return EstimationOption();
  //   }
}
