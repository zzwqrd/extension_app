import 'dart:developer';

import 'package:extension_app/core/utils/ui_extensions/box_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/color_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/sizing_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/text_style_extensions.dart';
import 'package:extension_app/di/service_locator.dart' show sl;
import 'package:extension_app/features/splash/presentation/controller/controller.dart';
import 'package:extension_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../controller/state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) {
        final cubit = sl<SplashCubit>();

        cubit.start();
        return cubit;
      },
      child: BlocListener<SplashCubit, SplashState>(
        listenWhen: (previous, current) => current.status == SplashStatus.ready,
        listener: (context, state) {
          if (state.status == SplashStatus.ready) {
            log("splash ready -> ${state.nextRoute}");
            final next = state.nextRoute ?? NamedRoutes.i.login;
            Navigator.of(context).pushReplacementNamed(next);
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              'Welcome To Back'.styled(
                context.titleMedium.bold.xl2.copyWith(color: context.success),
              ),
              12.h,
              MyAssets.icons.logo.svg(width: 100).roundedFull,
            ],
          ).center,
        ),
      ),
    );
  }
}
