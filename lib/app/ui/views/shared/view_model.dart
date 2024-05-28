import 'package:flutter/material.dart' hide View;

abstract class ViewModel extends ChangeNotifier {
  // bool _busy = false;
  // bool get isBusy => _busy;

  // void setBusy(bool value) {
  //   _busy = value;
  //   notifyListeners();
  // }

  // /// This method is executed exactly once for each State object Flutter's
  // ///  framework creates.
  // void init() {}

  // ///  This method is executed whenever the Widget's Stateful State gets
  // /// disposed. It might happen a few times, always matching the amount
  // /// of times `init` is called.
  // @override
  // void dispose();

  ViewModel() {
    _disposed = false;
  }

  bool _busy = false;
  bool get isBusy => _busy;

  bool _disposed = true;
  bool get isDisposed => _disposed;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
