import 'package:decimal/decimal.dart';
import 'package:palcal/app/core/enums/cardbox_type.dart';

class CardboardBox {
  final CardboardBoxType type;
  final int length;
  final int width;
  final double surfaceArea;
  final double caliper;
  final int grammage;

  CardboardBox({required this.type, required this.length, required this.width, required this.surfaceArea, required this.caliper, required this.grammage});

  get weight {
    return Decimal.fromInt(grammage) * Decimal.parse(surfaceArea.toString()) / Decimal.fromInt(10000);
  }
}
