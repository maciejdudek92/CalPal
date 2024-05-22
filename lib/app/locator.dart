import 'package:get_it/get_it.dart';
import 'package:palcal/app/core/view_models/estimator_view_model.dart';
import 'package:palcal/app/core/view_models/estimator_form_view_model.dart';

final locator = GetIt.instance;

void setupLocator() async {
  // locator.registerLazySingleton(() => EstimatorViewModel());
  // locator.registerLazySingleton(() => EstimatorFormViewModel());
  locator.registerSingleton(EstimatorViewModel());
  locator.registerFactory(() => EstimatorFormViewModel());
}
