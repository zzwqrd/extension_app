import 'dart:async';
import 'dart:io';

import 'package:croppy/croppy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'config/get_platform.dart';
import 'config/internet_checker.dart';
import 'core/services/bloc_observer.dart';
import 'core/utils/loger.dart';
import 'di/service_locator.dart' as di;

/// 🧭 Global instances (shared across the app)
final logger = LoggerDebug(headColor: LogColors.green);
final internetChecker = InternetChecker();
late SharedPreferences preferences;

/// 🚀 Application entry point
Future<void> main() async {
  /// Attach global Bloc observer for debugging Cubit/BLoC transitions
  Bloc.observer = AppBlocObserver();

  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    _logStartupMessage();

    /// Allow self-signed certificates (if required)
    HttpOverrides.global = MyHttpOverrides();

    /// Load local preferences
    preferences = await SharedPreferences.getInstance();

    /// Initialize platform & croppy config
    await _init();

    /// Initialize Dependency Injection
    await di.initGitIt();

    /// Initialize localization engine
    await EasyLocalization.ensureInitialized();

    /// Initialize responsive design utilities
    await ScreenUtil.ensureScreenSize();

    /// 🔧 Global system-level configurations before launching the app
    await _preLaunchConfigurations();

    /// 🏁 Launch the app wrapped with EasyLocalization
    runApp(
      EasyLocalization(
        path: 'assets/lang',
        saveLocale: true,
        startLocale: const Locale('ar'),
        fallbackLocale: const Locale('en'),
        supportedLocales: const [Locale('ar'), Locale('en')],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) => _handleUncaughtError(error, stackTrace));
}

/// 🧩 Initialize any platform-specific or low-level configs
Future<void> _init() async {
  pt = PlatformInfo.getCurrentPlatformType();

  // Force use of CassowaryDartImpl for Croppy on non-web platforms
  if (pt.isNotWeb) {
    croppyForceUseCassowaryDartImpl = true;
  }
}

/// ⚙️ Handle all global pre-launch configurations in parallel
Future<void> _preLaunchConfigurations() async {
  await Future.wait([
    /// 🔒 Restrict orientation to portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),

    /// 🌓 System UI styling (status bar & navigation bar)
    Future.microtask(() {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }),

    /// 💾 Load any saved settings from preferences
    Future.microtask(() async {
      // final savedLang = preferences.getString('lang');
      // logger.blue('🌍 Loaded language: ${savedLang ?? 'default (ar)'}');
    }),

    /// 🔮 Placeholder for optional services (e.g. remote config / analytics)
    Future.microtask(() async {
      // await RemoteConfigService.instance.load();
      // await AnalyticsService.instance.init();
    }),
  ]);
}

/// 🧱 Unified error handler for uncaught exceptions
void _handleUncaughtError(Object error, StackTrace stackTrace) {
  FlutterError.reportError(
    FlutterErrorDetails(
      exception: error,
      stack: stackTrace,
      library: 'AppInitializer',
      context: ErrorDescription('Unhandled error in AppInitializer'),
    ),
  );

  logger.red('❌ Unhandled error: $error');
  logger.yellow('📜 Stack trace: $stackTrace');
}

/// 💬 Startup message logger
void _logStartupMessage() {
  logger.green('اللهم صلي وسلم وبارك على سيدنا محمد وعلى آله وصحبه 💕');
  logger.blue('🚀 Application initialization started...');
}
