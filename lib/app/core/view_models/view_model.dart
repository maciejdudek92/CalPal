import 'package:flutter/material.dart';
import 'package:palcal/app/core/enums/view_state.dart';

abstract class ViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;
  void setState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }
}
