import 'package:decimal/decimal.dart';
import 'package:palcal/app/core/models/cardboard_box_model.dart';
import 'package:palcal/app/core/models/outer_box_model.dart';

class Palette {
  int layers;
  double height;
  List<OuterBox>? outerBoxes;
  List<CardboardBox>? flatBoxes;

  Palette({required this.layers, required this.height, this.outerBoxes, this.flatBoxes});

  get boxesPerOuter {
    return outerBoxes!.first.cardboardBoxes!.length;
  }

  get boxesPerLayer {
    int outersPerLayer = outerBoxes!.length ~/ layers;
    return outersPerLayer ~/ outerBoxes!.first.cardboardBoxes!.length;
  }
}
