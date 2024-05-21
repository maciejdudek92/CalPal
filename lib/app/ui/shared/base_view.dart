import 'package:flutter/material.dart';
import 'package:palcal/app/core/view_models/view_model.dart';
import 'package:palcal/app/locator.dart';
import 'package:provider/provider.dart';

abstract class BaseView<T extends ViewModel> extends StatefulWidget {
  void onModelReady(T viewModel);
  Widget build(BuildContext context, T model, Widget? child);
  const BaseView({super.key});
  @override
  State<BaseView> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ViewModel> extends State<BaseView> {
  T model = locator<T>();

  @override
  void initState() {
    widget.onModelReady(model);
    super.initState();
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
