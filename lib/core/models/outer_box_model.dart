import 'package:calpal/core/models/cardboard_box_model.dart';
import 'package:decimal/decimal.dart';

enum OuterBoxTypes {
  e,
  b,
  c,
  eb,
  bc;
}

class OuterBox {
  final OuterBoxTypes type = OuterBoxTypes.bc;
  int length;
  int width;
  int height;
  List<CardboardBox> cardboardBoxes;

  OuterBox(
      {required int length,
      required int width,
      required int height,
      this.cardboardBoxes = const []})
      : length = length + 15,
        width = width + 15,
        height = width + 15;

  int get cardboxesCount => cardboardBoxes.length;

  double get weight {
    Decimal weight = Decimal.parse('500');
    cardboardBoxes.forEach((box) {
      weight += Decimal.parse(box.weight.toString());
    });

    return (weight.toDouble() / 1000);
  }
}
