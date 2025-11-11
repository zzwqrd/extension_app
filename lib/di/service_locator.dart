import 'package:get_it/get_it.dart';

import '../features/auth/login/presentation/manager/controller.dart'
    show LoginCubit;
import '../features/splash/presentation/controller/controller.dart';

final GetIt sl = GetIt.instance;

Future<void> initGitIt() async {
  if (!sl.isRegistered<SplashCubit>()) {
    sl.registerFactory<SplashCubit>(() => SplashCubit());
  }

  sl.registerFactory<LoginCubit>(() => LoginCubit());
  // sl.registerFactory<CategoryCubit>(() => CategoryCubit());
}
