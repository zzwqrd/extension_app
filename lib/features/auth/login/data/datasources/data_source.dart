import 'package:dartz/dartz.dart';
import 'package:extension_app/core/services/dio_services.dart';
import 'package:extension_app/core/services/model.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/enums.dart';
import '../models/model.dart';

class LoginDataSourceImpl {
  Future<Either<HelperResponse, UserModel>> login(LoginModel loginModel) async {
    try {
      final response = await DioServices().post(
        AppConstants.login,
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(response);
      }
    } catch (e) {
      return Left(
        HelperResponse(
          statusCode: 500,
          message: e.toString(),
          state: ResponseState.unknownError,
          success: false,
        ),
      );
    }
  }
}
