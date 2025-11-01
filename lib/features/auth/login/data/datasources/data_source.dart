import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' show visibleForTesting;

import '../../../../../core/services/helper_respons.dart';
import '../../../../../core/services/services_api.dart';
import '../../../../../core/utils/constant.dart';
import '../models/model.dart';
import '../models/model_e.dart';

/// 🚀 DataSource الخاص بعملية تسجيل الدخول
/// before refactor using ServicesApi mixin
// class LoginDataSourceImpl {
//   Future<Either<HelperResponse, GetDataUserModel>> login(
//     LoginModel loginModel,
//   ) async {
//     final response = await DioServices.instance.post(
//       AppConstants.login,
//       data: loginModel.toJson(),
//     );

//     if (response.statusCode == 200) {
//       return Right(GetDataUserModel.fromJson(response.data));
//     } else {
//       return Left(response);
//     }
//   }
// }
// after refactor using ServicesApi mixin
// class LoginDataSourceImpl with ServicesApi {
//   Future<Either<HelperResponse, GetDataUserModel>> login(
//     LoginModel loginModel,
//   ) async {
//     final result = await postRequest(
//       AppConstants.login,
//       data: loginModel.toJson(),
//       requireAuth: false,
//     );

//     return result.fold(
//       (l) => Left(l),
//       (r) => Right(GetDataUserModel.fromJson(r)),
//     );
//   }
// }
class LoginDataSourceImpl with ServicesApi {
  Future<Either<HelperResponse, GetDataUserModel>> login(
    LoginModel loginModel,
  ) async {
    return await postRequest<GetDataUserModel>(
      AppConstants.login,
      data: loginModel.toJson(),
      requireAuth: false,
      fromJson: (json) => GetDataUserModel.fromJson(json),
    );
  }

  // getUserData method is commented out, can be implemented similarly if needed
  //الداله ليست لها استخدام فقط لتوضيح جلب البينات من api في حالت الليست
  @visibleForTesting
  Future<Either<HelperResponse, GetDataUserModel>> getUserData() async {
    return await getRequest(
      AppConstants.home,
      requireAuth: true,
      fromJson: (json) => json
          .map<GetDataUserModel>((e) => GetDataUserModel.fromJson(e))
          .toList(),
    );
  }
}
