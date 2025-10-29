import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:extension_app/core/routes/routes.dart';

import 'state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial());

  Future<void> start() async {
    emit(const SplashState.loading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      final next = await _determineNextRoute();

      emit(SplashState.ready(nextRoute: next));
    } catch (e) {
      emit(SplashState.error(e.toString()));
    }
  }

  Future<String> _determineNextRoute() async {
    return NamedRoutes.i.login;
  }
}
