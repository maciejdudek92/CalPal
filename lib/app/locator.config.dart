// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:palcal/app/core/view_models/estimator_form_view_model.dart'
    as _i4;
import 'package:palcal/app/core/view_models/glued_options_view_model.dart'
    as _i5;
import 'package:palcal/app/ui/views/main/estimator_view_model.dart'
    as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.EstimatorViewModel>(() => _i3.EstimatorViewModel());
    gh.factory<_i4.EstimatorFormViewModel>(() => _i4.EstimatorFormViewModel());
    gh.factory<_i5.GluedOptionsViewModel>(() => _i5.GluedOptionsViewModel());
    return this;
  }
}
