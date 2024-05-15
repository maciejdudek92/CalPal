import 'package:decimal/decimal.dart';

enum CardboardBoxType {
  glued,
  flat;
}

class CardboardBox {
  final CardboardBoxType type;
  final int length;
  final int width;
  final double aurfaceArea;
  final double caliper;
  final int grammage;

  CardboardBox({required this.type, required this.length, required this.width, required this.aurfaceArea, required this.caliper, required this.grammage});

  get weight {
    return Decimal.fromInt(grammage) * Decimal.parse(aurfaceArea.toString()) / Decimal.fromInt(10000);
  }
}
