import 'package:decimal/decimal.dart';
import 'package:palcal/models/outer_box_model.dart';

class Palette {
  int layers;
  double height;
  List<OuterBox> outerBoxes;

  Palette({required this.layers, required this.height, required this.outerBoxes});

  get boxesPerOuter {
    return outerBoxes.first.cardboardBoxes.length;
  }

  get boxesPerLayer {
    int outersPerLayer = outerBoxes.length ~/ layers;
    return outersPerLayer ~/ outerBoxes.first.cardboardBoxes.length;
  }
}
