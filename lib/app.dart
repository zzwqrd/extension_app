import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/app_routes_fun.dart';
import 'core/utils/phoneix.dart';
import 'core/utils/unfucs.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Alicom',
          initialRoute: AppRoutes.init.initial,
          routes: AppRoutes.init.appRoutes,
          navigatorKey: navigatorKey,
          navigatorObservers: <NavigatorObserver>[routeObserver],
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // theme: AppThemes.light, //Using edited theme
          // onGenerateRoute: AppRoutes.onGenerateRoute, //using edited route
          scrollBehavior: MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return Scaffold(
                appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
              );
            };
            return Phoenix(
              child: MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(1.sp.clamp(1.0, 1.5)),
                  accessibleNavigation: mediaQuery.accessibleNavigation,
                  boldText: mediaQuery.boldText,
                  highContrast: mediaQuery.highContrast,
                  padding: mediaQuery.padding,
                  viewInsets: mediaQuery.viewInsets,
                  devicePixelRatio: mediaQuery.devicePixelRatio,
                  alwaysUse24HourFormat: true,
                  platformBrightness: Theme.of(context).brightness,
                  disableAnimations: mediaQuery.disableAnimations,
                  gestureSettings: const DeviceGestureSettings(touchSlop: 10.0),
                ),
                // data: MediaQuery.of(context).copyWith(
                //   textScaler: TextScaler.linear(1.sp > 1.2 ? 1.2 : 1.sp),
                // ),
                child: Unfocus(child: child ?? const SizedBox.shrink()),
              ),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

late final SharedPreferences preferences;
