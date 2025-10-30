import 'package:dartz/dartz.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../data/models/model.dart';
import '../../data/models/model_e.dart';
import '../../data/repositories/repository.dart';

abstract class LoginUsecase {
  Future<Either<HelperResponse, GetDataUserModel>> call(LoginModel loginModel);
}

class LoginUseCaseImpl implements LoginUsecase {
  final loginRepository = LoginRepositoryImpl();

  @override
  Future<Either<HelperResponse, GetDataUserModel>> call(
    LoginModel loginModel,
  ) async {
    return await loginRepository.login(loginModel);
  }
}
