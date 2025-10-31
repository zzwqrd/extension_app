import 'package:easy_localization/easy_localization.dart';
import 'package:extension_app/core/utils/ui_extensions/box_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/extensions_init.dart';
import 'package:extension_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../commonWidget/app_field.dart';
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
      body: Form(
        key: bloc.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            // before:
            // Image.asset(MyAssets.images.logo.path, width: 150.w).pb8,
            // after:
            MyAssets.icons.logo.svg(width: 150.w).pb8,

            // before:
            // Flexible(child: Center(child: Text('Login View'))),
            // after:
            'Login View'.h1.center.pb8,
            // before:
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: tr(LocaleKeys.auth_email_placeholder),
            //   ),
            //   controller: TextEditingController(text: bloc.loginModel.email),
            // ).pb3,
            // after:
            AppCustomForm.email(
              hintText: tr(LocaleKeys.auth_email_placeholder),
              controller: TextEditingController(text: bloc.loginModel.email),
            ).pb3,

            AppCustomForm.password(
              hintText: tr(LocaleKeys.auth_password_placeholder),
              controller: TextEditingController(text: bloc.loginModel.password),
            ).pb6,

            BlocBuilder<LoginCubit, LoginState>(
              bloc: bloc,
              builder: (context, state) {
                return LoadingButton(
                  isAnimating: state.requestState.isLoading,
                  title: tr(LocaleKeys.auth_title),
                  onTap: () {
                    bloc.login();
                  },
                );
              },
            ),
          ],
        ).center.pb8.px4,
      ),
    );
  }
}
