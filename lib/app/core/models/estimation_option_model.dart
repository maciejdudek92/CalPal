import 'package:palcal/app/core/models/cardboard_box_model.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';

class EstimationOption {
  String name;
  int layers;
  double height;
  List<OuterBox>? outerBoxes;
  List<CardboardBox>? flatCardboardBoxes;

  EstimationOption({required this.name, required this.layers, required this.height, this.outerBoxes, this.flatCardboardBoxes});

  double get cardboardBoxWeight {
    if (outerBoxes != null) {
      return outerBoxes!.first.weight.toDouble();
    } else if (flatCardboardBoxes != null) {
      return flatCardboardBoxes!.first.weight.toDouble();
    } else {
      return 0.0;
    }
  }

  int get boxesPerOuter {
    return outerBoxes!.first.cardboardBoxes.length;
  }

  int get boxesPerLayer {
    int outersPerLayer = outerBoxes!.length ~/ layers;
    return boxesPerOuter * outersPerLayer;
  }

  int get boxesPerPalette {
    return boxesPerLayer * layers;
  }

  double get paletteHeight {
    // return 0;
    int boxHeight = outerBoxes!.first.height;
    double paletteHeight = ((boxHeight * layers) + 250) / 1000;
    return paletteHeight;
  }

  double get paletteWeight {
    // return 0;
    double boxWeight = outerBoxes!.first.weight;
    double paletteWeight = (boxWeight * outerBoxes!.length);
    return paletteWeight.roundToDouble();
  }

  // factory EstimationOption.fromJson(Map<String, Object?> json) => {

  //   return EstimationOption();
  //   }
}
