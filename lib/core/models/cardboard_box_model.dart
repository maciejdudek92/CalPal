import 'package:calpal/core/enums/cardbox_type.dart';
import 'package:decimal/decimal.dart';

class CardboardBox {
  final CardboardBoxType type;
  final int length;
  final int width;
  final double surfaceArea;
  final double caliper;
  final int grammage;
  final int foldLayers;

  CardboardBox(
      {required this.type,
      required this.length,
      required this.width,
      required this.surfaceArea,
      required this.caliper,
      required this.grammage,
      required this.foldLayers});

  double get weight {
    return ((Decimal.fromInt(grammage) *
                Decimal.parse(surfaceArea.toString())) /
            Decimal.fromInt(10000))
        .toDouble();
  }
}
