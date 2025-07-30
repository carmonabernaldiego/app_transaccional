import 'package:flutter/material.dart';
import '../viewmodels/register_viewmodel.dart';

class RegisterProvider extends InheritedNotifier<RegisterViewModel> {
  const RegisterProvider({super.key, required RegisterViewModel viewModel, required Widget child})
      : super(notifier: viewModel, child: child);

  static RegisterViewModel of(BuildContext context) {
    final RegisterProvider? result = context.dependOnInheritedWidgetOfExactType<RegisterProvider>();
    assert(result != null, 'No RegisterProvider found in context');
    return result!.notifier!;
  }

  @override
  bool updateShouldNotify(RegisterProvider oldWidget) => true;
}
