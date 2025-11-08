import 'package:dartz/dartz.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../domain/repositories/repository.dart' show LoginRepository;
import '../datasources/category_remote_data_source.dart';
import '../datasources/data_source.dart';
import '../models/categories.dart';
import '../models/login_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final loginDataSource = LoginDataSourceImpl();
  final c = CategoryRemoteDataSource();

  @override
  Future<Either<HelperResponse, Map<String, dynamic>>> completeLogin(
    LoginModel loginModel,
  ) async {
    return await loginDataSource.completeLogin(loginModel);
  }

  @override
  Future<Either<HelperResponse, ModelsCategories>> getCategories() {
    return c.getCategories();
  }
}
