import 'package:dartz/dartz.dart';

import '../../../../../core/services/api_client.dart';
import '../../../../../core/services/helper_respons.dart';
import '../models/login_model.dart';

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
// class LoginDataSourceImpl with ApiClient {
//   Future<Either<HelperResponse, GetDataUserModel>> login(
//     LoginModel loginModel,
//   ) async {
//     return await postRequest<GetDataUserModel>(
//       AppConstants.login,
//       data: loginModel.toJson(),
//       requireAuth: false,
//       fromJson: (json) => GetDataUserModel.fromJson(json),
//     );
//   }

//   // getUserData method is commented out, can be implemented similarly if needed
//   //الداله ليست لها استخدام فقط لتوضيح جلب البينات من api في حالت الليست
//   @visibleForTesting
//   Future<Either<HelperResponse, GetDataUserModel>> getUserData() async {
//     return await getRequest(
//       AppConstants.home,
//       requireAuth: true,
//       fromJson: (json) => json
//           .map<GetDataUserModel>((e) => GetDataUserModel.fromJson(e))
//           .toList(),
//     );
//   }
// }

class LoginDataSourceImpl with ApiClient {
  /// 🔐 تسجيل الدخول باستخدام GraphQL
  Future<Either<HelperResponse, LoginResponse>> login(
    LoginModel loginModel,
  ) async {
    const String mutation = '''
    mutation GenerateCustomerToken(\$email: String!, \$password: String!) {
      generateCustomerToken(email: \$email, password: \$password) {
        token
      }
    }
    ''';

    return await graphQLMutation<LoginResponse>(
      mutation,
      variables: {'email': loginModel.email, 'password': loginModel.password},
      requireAuth: false,
      fromJson: (json) {
        return LoginResponse.fromJson(json);
      },
      dataKey: 'generateCustomerToken',
    );
  }

  /// 👤 جلب بيانات المستخدم بعد التسجيل
  Future<Either<HelperResponse, Customer>> getCustomerData() async {
    const String query = '''
    query GetCustomer {
      customer {
        id
        firstname
        lastname
        email
        date_of_birth
        gender
        is_subscribed
        addresses {
          firstname
          lastname
          street
          city
          region {
            region_code
            region
          }
          postcode
          country_code
          telephone
        }
      }
    }
    ''';

    return await graphQLQuery<Customer>(
      query,
      requireAuth: true, // يحتاج توكن
      fromJson: (json) {
        return Customer.fromJson(json);
      },
      dataKey: 'customer',
    );
  }

  /// 🔄 عملية تسجيل الدخول الكاملة (الحصول على التوكن + بيانات المستخدم)
  Future<Either<HelperResponse, Map<String, dynamic>>> completeLogin(
    LoginModel loginModel,
  ) async {
    // ١. تسجيل الدخول والحصول على التوكن
    final loginResult = await login(loginModel);

    return loginResult.fold((error) => Left(error), (loginResponse) async {
      // ٢. جلب بيانات المستخدم باستخدام التوكن
      final customerResult = await getCustomerData();

      return customerResult.fold((error) => Left(error), (customer) {
        // ٣. إرجاع كل البيانات معاً
        return Right({'token': loginResponse.token, 'customer': customer});
      });
    });
  }
}
