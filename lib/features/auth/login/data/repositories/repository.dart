import 'package:dartz/dartz.dart';

import '../../../../../core/services/helper_respons.dart';
import '../datasources/data_source.dart';
import '../models/model.dart';
import '../models/model_e.dart';

abstract class LoginRepository {
  Future<Either<HelperResponse, GetDataUserModel>> login(LoginModel loginModel);
}

class LoginRepositoryImpl implements LoginRepository {
  final loginDataSource = LoginDataSourceImpl();

  @override
  Future<Either<HelperResponse, GetDataUserModel>> login(
    LoginModel loginModel,
  ) async {
    return await loginDataSource.login(loginModel);
  }
}
