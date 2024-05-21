import 'package:get_it/get_it.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';

final locator = GetIt.instance;

void setupLocator() async {
  locator.registerSingleton<EstimatorViewModel>(EstimatorViewModel());
}
