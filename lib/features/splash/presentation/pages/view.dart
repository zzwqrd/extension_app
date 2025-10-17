import 'package:extension_app/core/utils/ui_extensions/box_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/color_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/sizing_extensions.dart';
import 'package:extension_app/core/utils/ui_extensions/text_style_extensions.dart';
import 'package:extension_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          'Welcome To Back'.styled(context.titleMedium.bold.xl2.copyWith(color: context.success)),
          12.h,
          MyAssets.icons.icon.image(width: 100).roundedFull,
        ],
      ).center,
    );
  }
}
