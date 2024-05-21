import 'package:decimal/decimal.dart';
import 'package:palcal/app/core/models/cardboard_box_model.dart';

enum OuterBoxTypes {
  e,
  b,
  c,
  eb,
  bc;
}

class OuterBox {
  final OuterBoxTypes type = OuterBoxTypes.bc;
  int? length;
  int? width;
  int? height;
  List<CardboardBox>? cardboardBoxes;

  OuterBox({this.length, this.width, this.height, this.cardboardBoxes});

  Decimal get weight {
    Decimal weight = Decimal.zero;
    cardboardBoxes!.forEach((box) {
      weight += box.weight;
    });
    return weight;
  }
}
