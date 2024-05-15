import 'package:decimal/decimal.dart';
import 'package:palcal/models/cardboard_box_model.dart';

enum OuterBoxTypes {
  e,
  b,
  c,
  eb,
  bc;
}

class OuterBox {
  final OuterBoxTypes type = OuterBoxTypes.bc;
  final int length;
  final int width;
  final int height;
  List<CardboardBox> cardboardBoxes;

  OuterBox({required this.length, required this.width, required this.height, required this.cardboardBoxes});

  Decimal get weight {
    Decimal weight = Decimal.zero;
    cardboardBoxes.forEach((box) {
      weight += box.weight;
    });
    return weight;
  }
}
