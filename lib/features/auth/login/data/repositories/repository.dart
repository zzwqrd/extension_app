import 'package:dartz/dartz.dart';
import 'package:extension_app/core/services/model.dart';

import '../../../../../core/services/helper_respons.dart';
import '../datasources/data_source.dart';
import '../models/model.dart';

abstract class LoginRepository {
  Future<Either<HelperResponse, UserModel>> login(LoginModel loginModel);
}

class LoginRepositoryImpl implements LoginRepository {
  final loginDataSource = LoginDataSourceImpl();

  @override
  Future<Either<HelperResponse, UserModel>> login(LoginModel loginModel) async {
    return await loginDataSource.login(loginModel);
  }
}
