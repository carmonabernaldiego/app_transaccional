import 'package:flutter/material.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginProvider extends InheritedNotifier<LoginViewModel> {
  const LoginProvider({super.key, required LoginViewModel viewModel, required Widget child})
      : super(notifier: viewModel, child: child);

  static LoginViewModel of(BuildContext context) {
    final LoginProvider? result = context.dependOnInheritedWidgetOfExactType<LoginProvider>();
    assert(result != null, 'No LoginProvider found in context');
    return result!.notifier!;
  }

  @override
  bool updateShouldNotify(LoginProvider oldWidget) => true;
}
