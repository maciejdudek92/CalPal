import 'package:flutter/material.dart';
import 'package:palcal/app/ui/views/shared/view_model.dart';
import 'package:palcal/app/locator.dart';
import 'package:provider/provider.dart';

//https://marajhussain.medium.com/flutter-mvvm-architecture-best-practice-using-provide-http-4939bdaae171
//https://medium.com/@buttonsrtoys/mvvm-with-flutter-e162a59984cf

enum AAAStateMixin {
  singleTicketProvider,
  ticketProvider,
}

class ViewAAA<T extends ViewModel> extends StatefulWidget {
  final AAAStateMixin? withStateMixin;
  final Function(T viewModel)? onModelReady;
  final Function(T viewModel)? onModelDispose;
  final Function(TickerProvider tickerProvider)? withTickerProvider;
  final Widget Function(BuildContext context, T viewModel, Widget? _) builder;

  // ignore: use_super_parameters
  const ViewAAA({Key? key, this.withStateMixin, this.onModelReady, this.onModelDispose, this.withTickerProvider, required this.builder}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ViewAAA> createState() {
    switch (withStateMixin) {
      case AAAStateMixin.singleTicketProvider:
        return _SingleTickerViewState<T>();
      case AAAStateMixin.ticketProvider:
        return _TickerViewState<T>();
      default:
        return _ViewState<T>();
    }
  }

  // @override
  // State<ViewAAA> createState() => _ViewState<T>();
}

class _ViewState<T extends ViewModel> extends State<ViewAAA<T>> {
  T viewModel = locator<T>();
  @override
  void initState() {
    super.initState();
    // if (widget.withTickerProvider != null) {
    //   throw Exception("Function withStateMixin must be provided!");
    // }
    // viewModel.onModelInit();
    if (widget.onModelReady != null) {
      widget.onModelReady!(viewModel);
    }
  }

  @override
  void dispose() {
    if (widget.onModelDispose != null) {
      widget.onModelDispose!(viewModel);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (viewModel.isDisposed) {
    //   return ChangeNotifierProvider<T>(
    //     create: (context) => viewModel,
    //     child: Consumer<T>(builder: widget.builder),
    //   );
    // }
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}

class _SingleTickerViewState<T extends ViewModel> extends _ViewState<T> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    bool hasStateMixin = widget.withStateMixin == AAAStateMixin.singleTicketProvider;
    bool hasWithTickerProvider = widget.withTickerProvider != null;

    if (hasStateMixin == hasWithTickerProvider) {
      widget.withTickerProvider!(this);
    } else {
      throw Exception("withStateMixin and withTickerProvider must be provided!");
    }
    super.initState();
  }
}

class _TickerViewState<T extends ViewModel> extends _ViewState<T> with TickerProviderStateMixin {
  @override
  void initState() {
    bool hasStateMixin = widget.withStateMixin == AAAStateMixin.ticketProvider;
    bool hasWithTickerProvider = widget.withTickerProvider != null;
    if (hasStateMixin == hasWithTickerProvider) {
      widget.withTickerProvider!(this);
    } else {
      throw Exception("withStateMixin and withTickerProvider must be provided!");
    }
    super.initState();
  }
}


// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart' hide View;
// import 'package:palcal/app/ui/views/shared/view_model.dart';
// import 'package:palcal/app/locator.dart';
// import 'package:provider/provider.dart';

// //https://marajhussain.medium.com/flutter-mvvm-architecture-best-practice-using-provide-http-4939bdaae171
// //https://medium.com/@buttonsrtoys/mvvm-with-flutter-e162a59984cf

// enum StateMixin {
//   singleTicketProvider,
//   ticketProvider,
// }

// abstract class View<T extends ViewModel> extends StatefulWidget {
//   void initState(T viewModel);
//   // void dispose();
//   Widget build(BuildContext context, T viewModel, Widget? _);
//   const View({Key? key}) : super(key: key);

//   // @nonVirtual
//   // @override
//   // // ignore: no_logic_in_create_state
//   // State<View> createState() {
//   //   switch (stateMixin) {
//   //     case StateMixin.singleTicketProvider:
//   //       return _ViewSingleTickerProviderState<T>();
//   //     case StateMixin.ticketProvider:
//   //       return _ViewTickerProviderState<T>();
//   //     default:
//   //       return _ViewState<T>();
//   //   }
//   // }
//   @override
//   State<View> createState() => _ViewState<T>();
// }

// class _ViewState<T extends ViewModel> extends State<View> {
//   T viewModel = locator<T>();

//   @mustCallSuper
//   @override
//   void initState() {
//     super.initState();
//     // viewModel.init();
//   }

//   @mustCallSuper
//   @override
//   void dispose() {
//     viewModel.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>.value(
//       value: viewModel,
//       child: Consumer<T>(builder: widget.build),
//     );
//   }
// }

// abstract class MyView<T extends ViewModel> extends StatelessWidget {
//   T viewModel = locator<T>();

//   Widget builder(BuildContext context, T viewModel, Widget? _);
//   MyView();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>.value(
//       value: viewModel,
//       child: Consumer<T>(builder: builder),
//     );
//   }
// }

// // class _ViewState<T extends ViewModel> extends _ViewState<T> {
// //   @override
// //   void initState() {
// //     widget.initState();
// //     super.initState();
// //   }
// // }

// // class _ViewSingleTickerProviderState<T extends ViewModel> extends _ViewState<T> with SingleTickerProviderStateMixin {
// //   @override
// //   void initState() {
// //     widget.initState(this, model);
// //     super.initState();
// //   }
// // }

// // class _ViewTickerProviderState<T extends ViewModel> extends _ViewState<T> with TickerProviderStateMixin {
// //   @override
// //   void initState() {
// //     widget.initState(this, model);
// //     super.initState();
// //   }
// // }
