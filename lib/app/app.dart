import 'package:calpal/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:calpal/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:calpal/ui/views/home/home_view.dart';
import 'package:calpal/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:calpal/ui/dialogs/add_estimation_option/add_estimation_option_dialog.dart';
import 'package:calpal/ui/views/estimation_options/estimation_options_view.dart';
import 'package:calpal/services/estimator_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: EstimationOptionsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: EstimatorService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddEstimationOptionDialog),
// @stacked-dialog
  ],
)
class App {}
