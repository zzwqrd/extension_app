import 'package:dartz/dartz.dart';
import 'package:extension_app/core/services/model.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../data/models/model.dart';
import '../../data/repositories/repository.dart';

abstract class LoginUseCaseImpl {
  Future<Either<HelperResponse, UserModel>> call(LoginModel loginModel);
}

class LoginUsecase implements LoginUseCaseImpl {
  final loginRepository = LoginRepositoryImpl();

  @override
  Future<Either<HelperResponse, UserModel>> call(LoginModel loginModel) async {
    return await loginRepository.login(loginModel);
  }
}
