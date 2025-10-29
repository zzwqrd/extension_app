import 'package:extension_app/features/auth/login/presentation/pages/view.dart';
import 'package:flutter/material.dart';

import '../../features/splash/presentation/pages/view.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.i.splash;
  AppRoutes._internal();
  Map<String, Widget Function(BuildContext c)> appRoutes = {
    NamedRoutes.i.splash: (c) => const SplashView(),
    NamedRoutes.i.login: (c) => const LoginView(),
    // NamedRoutes.i.layout: (c) => const LayoutView(),
    // NamedRoutes.i.home: (c) => HomeView(),
    // NamedRoutes.i.error: (context) => const ErrorView(),
    // NamedRoutes.i.internet: (context) => const ErrorInternetView(),
    // NamedRoutes.i.register: (context) => const RegisterView(),
    // Add other routes here
  };
}
