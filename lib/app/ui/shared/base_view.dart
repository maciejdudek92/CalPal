import 'package:flutter/material.dart';
import 'package:palcal/app/core/view_models/view_model.dart';
import 'package:palcal/app/locator.dart';
import 'package:provider/provider.dart';

enum StateMixin {
  singleTicketProvider,
  ticketProvider,
}

abstract class BaseView<T extends ViewModel> extends StatefulWidget {
  void initState(TickerProvider? _, T viewModel);
  void dispose();
  Widget build(BuildContext context, T model, Widget? child);
  final StateMixin? stateMixin;
  const BaseView({Key? key, this.stateMixin}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<BaseView> createState() {
    print(stateMixin);
    switch (stateMixin) {
      case StateMixin.singleTicketProvider:
        return _ViewSingleTickerProviderState<T>();
      case StateMixin.ticketProvider:
        return _ViewTickerProviderState<T>();
      default:
        return _ViewState<T>();
    }
  }
}

abstract class _BaseViewState<T extends ViewModel> extends State<BaseView> {
  T model = locator<T>();

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget._viewModelInstance.value = model;
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.build,
      ),
    );
  }
}

class _ViewState<T extends ViewModel> extends _BaseViewState<T> {
  @override
  void initState() {
    widget.initState(null, model);
    super.initState();
  }
}

class _ViewSingleTickerProviderState<T extends ViewModel> extends _BaseViewState<T> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.initState(this, model);
    super.initState();
  }
}

class _ViewTickerProviderState<T extends ViewModel> extends _BaseViewState<T> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.initState(this, model);
    super.initState();
  }
}
