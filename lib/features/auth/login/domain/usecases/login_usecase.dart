import 'package:dartz/dartz.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../data/models/categories.dart';
import '../../data/models/login_model.dart';
import '../../data/repositories/repository_impl.dart';

abstract class LoginUsecase {
  Future<Either<HelperResponse, Map<String, dynamic>>> call(
    LoginModel loginModel,
  );
  Future<Either<HelperResponse, ModelsCategories>> getCategories();
}

class LoginUseCaseImpl implements LoginUsecase {
  final loginRepository = LoginRepositoryImpl();

  @override
  Future<Either<HelperResponse, Map<String, dynamic>>> call(
    LoginModel loginModel,
  ) async {
    return await loginRepository.completeLogin(loginModel);
  }

  @override
  Future<Either<HelperResponse, ModelsCategories>> getCategories() async {
    return await loginRepository.getCategories();
  }
}
