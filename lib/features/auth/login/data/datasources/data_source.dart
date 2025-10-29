import 'package:dartz/dartz.dart';
import 'package:extension_app/core/services/dio_services.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../../../../core/utils/constant.dart';
import '../models/model.dart';
import '../models/model_e.dart';

class LoginDataSourceImpl {
  Future<Either<HelperResponse, GetDataUserModel>> login(
    LoginModel loginModel,
  ) async {
    final response = await DioServices().post(
      AppConstants.login,
      data: loginModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(GetDataUserModel.fromJson(response.data));
    } else {
      return Left(response);
    }
  }
}
