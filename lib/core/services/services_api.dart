import 'package:dartz/dartz.dart';

import 'dio_services.dart';
import 'helper_respons.dart';

/// 🌍 Base Mixin for any DataSource
/// يدعم generic parsing لأي نوع T
mixin ServicesApi {
  final DioServices _dio = DioServices.instance;

  /// -----------------------------
  /// 🟩 POST Request
  /// -----------------------------
  Future<Either<HelperResponse, T>> postRequest<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
    bool isFormData = false,
    T Function(dynamic json)? fromJson, // للتحويل الفردي
    T Function(List json)? fromJsonList, // للتحويل لقائمة
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        formData: formData,
        queryParameters: queryParameters,
        headers: headers,
        requireAuth: requireAuth,
        isFormData: isFormData,
      );

      if (response.statusCode == 200 &&
          response.isSuccess &&
          response.data != null) {
        final resData = response.data;

        // لو دالة fromJson موجودة
        if (fromJson != null) return Right(fromJson(resData));

        // لو دالة fromJsonList موجودة
        if (fromJsonList != null && resData is List) {
          return Right(fromJsonList(resData));
        }

        // لو T نفسه Map أو List مش محتاج fromJson
        if (resData is T) return Right(resData);

        // أي حالة تانية نرجع خطأ
        return Left(
          HelperResponse.badRequest(
            message: 'fromJson parser is required for type $T',
          ),
        );
      } else {
        return Left(response);
      }
    } catch (e) {
      return Left(HelperResponse.badRequest(message: e.toString()));
    }
  }

  /// -----------------------------
  /// 🟦 GET Request
  /// -----------------------------
  Future<Either<HelperResponse, T>> getRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
    bool cache = false,
    int retryCount = 0,
    T Function(dynamic json)? fromJson,
    List<T> Function(List json)? fromJsonList,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        headers: headers,
        requireAuth: requireAuth,
        cache: cache,
        retryCount: retryCount,
      );

      if (response.statusCode == 200 &&
          response.isSuccess &&
          response.data != null) {
        final resData = response.data;

        if (fromJson != null) return Right(fromJson(resData));
        if (fromJsonList != null && resData is List)
          return Right(fromJsonList(resData) as T);
        if (resData is T) return Right(resData);

        return Left(
          HelperResponse.badRequest(
            message: 'fromJson parser is required for type $T',
          ),
        );
      } else {
        return Left(response);
      }
    } catch (e) {
      return Left(HelperResponse.badRequest(message: e.toString()));
    }
  }

  /// -----------------------------
  /// 🟨 PUT Request
  /// -----------------------------
  Future<Either<HelperResponse, T>> putRequest<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
    T Function(dynamic json)? fromJson,
    List<T> Function(List json)? fromJsonList,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        requireAuth: requireAuth,
      );

      if (response.statusCode == 200 &&
          response.isSuccess &&
          response.data != null) {
        final resData = response.data;

        if (fromJson != null) return Right(fromJson(resData));
        if (fromJsonList != null && resData is List)
          return Right(fromJsonList(resData) as T);
        if (resData is T) return Right(resData);

        return Left(
          HelperResponse.badRequest(
            message: 'fromJson parser is required for type $T',
          ),
        );
      } else {
        return Left(response);
      }
    } catch (e) {
      return Left(HelperResponse.badRequest(message: e.toString()));
    }
  }

  /// -----------------------------
  /// 🟥 DELETE Request
  /// -----------------------------
  Future<Either<HelperResponse, T>> deleteRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
    T Function(dynamic json)? fromJson,
    List<T> Function(List json)? fromJsonList,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        headers: headers,
        requireAuth: requireAuth,
      );

      if (response.statusCode == 200 &&
          response.isSuccess &&
          response.data != null) {
        final resData = response.data;

        if (fromJson != null) return Right(fromJson(resData));
        if (fromJsonList != null && resData is List)
          return Right(fromJsonList(resData) as T);
        if (resData is T) return Right(resData);

        return Left(
          HelperResponse.badRequest(
            message: 'fromJson parser is required for type $T',
          ),
        );
      } else {
        return Left(response);
      }
    } catch (e) {
      return Left(HelperResponse.badRequest(message: e.toString()));
    }
  }
}

// /// 🌍 Base Mixin for any DataSource
// /// يدعم جميع أنواع الطلبات مع generic parsing باستخدام fromJson
// mixin ServicesApi {
//   final DioServices _dio = DioServices.instance;

//   /// 🟩 POST request wrapper
//   Future<Either<HelperResponse, T>> postRequest<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? formData,
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     bool isFormData = false,
//     T Function(dynamic json)? fromJson,
//   }) async {
//     try {
//       final response = await _dio.post<T>(
//         path,
//         data: data,
//         formData: formData,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//         isFormData: isFormData,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         if (fromJson != null && response.data != null) {
//           return Right(fromJson(response.data));
//         }
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟦 GET request wrapper
//   Future<Either<HelperResponse, T>> getRequest<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     bool cache = false,
//     int retryCount = 0,
//     T Function(dynamic json)? fromJson,
//   }) async {
//     try {
//       final response = await _dio.get<T>(
//         path,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//         cache: cache,
//         retryCount: retryCount,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         if (fromJson != null && response.data != null) {
//           return Right(fromJson(response.data));
//         }
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟨 PUT request wrapper
//   Future<Either<HelperResponse, T>> putRequest<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     T Function(dynamic json)? fromJson,
//   }) async {
//     try {
//       final response = await _dio.put<T>(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         if (fromJson != null && response.data != null) {
//           return Right(fromJson(response.data));
//         }
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟥 DELETE request wrapper
//   Future<Either<HelperResponse, T>> deleteRequest<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     T Function(dynamic json)? fromJson,
//   }) async {
//     try {
//       final response = await _dio.delete<T>(
//         path,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         if (fromJson != null && response.data != null) {
//           return Right(fromJson(response.data));
//         }
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟪 PATCH request wrapper
//   Future<Either<HelperResponse, T>> patchRequest<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     T Function(dynamic json)? fromJson,
//   }) async {
//     try {
//       final response = await _dio.patch<T>(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         if (fromJson != null && response.data != null) {
//           return Right(fromJson(response.data));
//         }
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }
// }

// /// 🌍 Base Mixin عام لأي DataSource
// /// بيوحّد طريقة استدعاء API مع استخدام Either<HelperResponse, T>
// mixin ServicesApi {
//   final DioServices _dio = DioServices.instance;

//   /// 🟩 POST request wrapper
//   Future<Either<HelperResponse, T>> postRequest<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? formData,
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     bool isFormData = false,
//   }) async {
//     try {
//       final response = await _dio.post<T>(
//         path,
//         data: data,
//         formData: formData,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//         isFormData: isFormData,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟦 GET request wrapper
//   Future<Either<HelperResponse, T>> getRequest<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//     bool cache = false,
//     int retryCount = 0,
//   }) async {
//     try {
//       final response = await _dio.get<T>(
//         path,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//         cache: cache,
//         retryCount: retryCount,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟨 PUT request wrapper
//   Future<Either<HelperResponse, T>> putRequest<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//   }) async {
//     try {
//       final response = await _dio.put<T>(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }

//   /// 🟥 DELETE request wrapper
//   Future<Either<HelperResponse, T>> deleteRequest<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//     bool requireAuth = true,
//   }) async {
//     try {
//       final response = await _dio.delete<T>(
//         path,
//         queryParameters: queryParameters,
//         headers: headers,
//         requireAuth: requireAuth,
//       );

//       if (response.statusCode == 200 && response.isSuccess) {
//         return Right(response.data as T);
//       } else {
//         return Left(response);
//       }
//     } catch (e) {
//       return Left(HelperResponse.badRequest(message: e.toString()));
//     }
//   }
// }

// // /// ✅ الميكسين ده هدفه يديك إمكانية استخدام دوال DioServices
// // /// من غير ما تورّث الكلاس كله ولا تنفذ كل الواجهات بنفسك.
// // mixin ServicesApi {
// //   /// نستخدم instance واحدة من DioServices
// //   final DioServices _dio = DioServices.instance;

// //   /// هنا نعمل wrapper حوالين دوال DioServices اللي محتاجينها فقط

// //   Future<HelperResponse<T>> get<T>(
// //     String path, {
// //     Map<String, dynamic>? queryParameters,
// //     Map<String, String>? headers,
// //     bool requireAuth = true,
// //     bool cache = false,
// //     int retryCount = 0,
// //   }) {
// //     return _dio.get(
// //       path,
// //       queryParameters: queryParameters,
// //       headers: headers,
// //       requireAuth: requireAuth,
// //       cache: cache,
// //       retryCount: retryCount,
// //     );
// //   }

// //   Future<HelperResponse<T>> post<T>(
// //     String path, {
// //     dynamic data,
// //     Map<String, dynamic>? formData,
// //     Map<String, dynamic>? queryParameters,
// //     Map<String, String>? headers,
// //     bool requireAuth = true,
// //     bool isFormData = false,
// //   }) {
// //     return _dio.post(
// //       path,
// //       data: data,
// //       formData: formData,
// //       queryParameters: queryParameters,
// //       headers: headers,
// //       requireAuth: requireAuth,
// //       isFormData: isFormData,
// //     );
// //   }

// //   Future<HelperResponse<T>> put<T>(
// //     String path, {
// //     dynamic data,
// //     Map<String, dynamic>? queryParameters,
// //     Map<String, String>? headers,
// //     bool requireAuth = true,
// //   }) {
// //     return _dio.put(
// //       path,
// //       data: data,
// //       queryParameters: queryParameters,
// //       headers: headers,
// //       requireAuth: requireAuth,
// //     );
// //   }

// //   Future<HelperResponse<T>> delete<T>(
// //     String path, {
// //     Map<String, dynamic>? queryParameters,
// //     Map<String, String>? headers,
// //     bool requireAuth = true,
// //   }) {
// //     return _dio.delete(
// //       path,
// //       queryParameters: queryParameters,
// //       headers: headers,
// //       requireAuth: requireAuth,
// //     );
// //   }
// // }
