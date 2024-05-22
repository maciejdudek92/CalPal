import 'package:flutter/material.dart';
import 'package:palcal/app/core/view_models/view_model.dart';
import 'package:palcal/app/locator.dart';
import 'package:provider/provider.dart';

enum StateMixins {
  withouMixins,
  withSingleTicketProvider,
  withTicketProvider,
}

abstract class BaseView<T extends ViewModel> extends StatefulWidget {
  void initState(state, T viewModel);
  void dispose();
  Widget build(BuildContext context, T model, Widget? child);
  final StateMixins? stateMixins;
  const BaseView({super.key, this.stateMixins});

  @override
  // ignore: no_logic_in_create_state
  State<BaseView> createState() {
    switch (stateMixins) {
      case StateMixins.withSingleTicketProvider:
        return _BaseViewSingleTickerProviderState<T>();
      case StateMixins.withTicketProvider:
        return _BaseViewTickerProviderState<T>();
      default:
        return _BaseViewState<T>();
    }
  }
}

class _BaseViewState<T extends ViewModel> extends State<BaseView> {
  T model = locator<T>();

  @override
  void initState() {
    widget.initState(this, model);
    super.initState();
  }

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

class _BaseViewSingleTickerProviderState<T extends ViewModel> extends State<BaseView> with SingleTickerProviderStateMixin {
  T model = locator<T>();

  @override
  void initState() {
    widget.initState(this, model);
    super.initState();
  }

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

class _BaseViewTickerProviderState<T extends ViewModel> extends State<BaseView> with TickerProviderStateMixin {
  T model = locator<T>();

  @override
  void initState() {
    widget.initState(this, model);
    super.initState();
  }

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
