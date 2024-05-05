import 'package:flutter/material.dart';
import 'bloc/auth_bloc.dart';

class MyApp extends InheritedWidget {
  final AuthBloc authBloc;
  final Widget child;

  MyApp(this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static MyApp of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyApp>()!;
}
