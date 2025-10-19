import 'package:get_it/get_it.dart';

import '../features/splash/presentation/controller/controller.dart';

final GetIt sl = GetIt.instance;

Future<void> initGitIt() async {
  if (!sl.isRegistered<SplashCubit>()) {
    sl.registerFactory<SplashCubit>(() => SplashCubit());
  }
}
