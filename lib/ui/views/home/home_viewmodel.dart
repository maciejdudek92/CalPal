import 'package:calpal/app/app.bottomsheets.dart';
import 'package:calpal/app/app.dialogs.dart';
import 'package:calpal/app/app.locator.dart';
import 'package:calpal/core/models/estimation_option_model.dart';
import 'package:calpal/services/estimator_service.dart';
import 'package:calpal/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  // final _estimatorSevice = locator<EstimatorService>();

  Future<void> showDialog() async => _dialogService.showCustomDialog(
        variant: DialogType.addEstimationOption,
        title: 'Stacked Rocks!',
        description: 'Give stacked  stars on Github',
      );

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
