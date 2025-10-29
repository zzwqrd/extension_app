import 'package:easy_localization/easy_localization.dart';
import 'package:extension_app/core/utils/ui_extensions/box_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commonWidget/button_animation/LoadingButton.dart'
    show LoadingButton;
import '../../../../../di/service_locator.dart';
import '../../../../../gen/locale_keys.g.dart';
import '../manager/controller.dart';
import '../manager/state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<LoginCubit>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(child: Text('Login View')).flex1,

          BlocBuilder<LoginCubit, LoginState>(
            bloc: bloc,
            builder: (context, state) {
              return LoadingButton(
                isAnimating: state.requestState.isLoading,
                title: tr(LocaleKeys.auth_title),
                onTap: () {
                  bloc.login("user@alicom.com", "secret");
                },
              );
            },
          ),
        ],
      ).center.pb8,
    );
  }
}
