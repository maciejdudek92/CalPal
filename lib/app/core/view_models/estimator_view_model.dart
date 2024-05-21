import 'package:palcal/app/core/models/outer_box_model.dart';
import 'package:palcal/app/core/models/palette_model.dart';
import 'package:palcal/app/core/view_models/view_model.dart';

class EstimatorViewModel extends ViewModel {
  final List<OuterBox> outerBoxesOptions = [
    OuterBox(length: 385, width: 385),
    OuterBox(length: 385, width: 285),
    OuterBox(length: 385, width: 250),
    OuterBox(length: 385, width: 225),
  ];
}

// 385x385 [3x2] -> OK
// 385x285 [2x4] -> OK
// 385x250 [3x3] -> OK
// 385x225 [5x2] -> OK
