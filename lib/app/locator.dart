import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:palcal/app/ui/views/main/estimator_view_model.dart';
import 'package:palcal/app/core/view_models/estimator_form_view_model.dart';
import 'package:palcal/app/core/view_models/glued_options_view_model.dart';
import 'locator.config.dart';

final locator = GetIt.instance;

// void setupLocator() async {
//   // locator.registerLazySingleton(() => EstimatorViewModel());
//   // locator.registerLazySingleton(() => EstimatorFormViewModel());
//   locator.registerSingleton(EstimatorViewModel());
//   locator.registerSingleton(GluedOptionsViewModel());
//   // locator.reg(EstimatorViewModel());

//   locator.registerFactory(() => EstimatorFormViewModel());
// }

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
// void configureDependencies() {}
