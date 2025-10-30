import 'package:dartz/dartz.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../domain/repositories/repository.dart' show LoginRepository;
import '../datasources/data_source.dart';
import '../models/model.dart';
import '../models/model_e.dart';

class LoginRepositoryImpl implements LoginRepository {
  final loginDataSource = LoginDataSourceImpl();

  @override
  Future<Either<HelperResponse, GetDataUserModel>> login(
    LoginModel loginModel,
  ) async {
    return await loginDataSource.login(loginModel);
  }
}
