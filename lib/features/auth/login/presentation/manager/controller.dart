import 'package:extension_app/core/utils/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../data/models/login_model.dart';
import '../../domain/usecases/login_usecase.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final LoginUsecase _loginUseCase = LoginUseCaseImpl();
  final formKey = GlobalKey<FormState>();

  LoginModel loginModel = LoginModel(
    email: "ahmed@alicom.com".trim(),
    password: "Password123!".trim(),
  );

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();

    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _loginUseCase(loginModel);

    result.fold(
      (l) {
        FlashHelper.showToast(l.message);
        emit(state.copyWith(requestState: RequestState.error));
      },

      (r) {
        FlashHelper.showToast(
          'تم تسجيل الدخول بنجاح',
          type: MessageTypeTost.success,
        );
        emit(state.copyWith(requestState: RequestState.done));
      },
    );
  }
}

// class CategoryState {
//   final RequestState requestState;
//   final ModelsCategories? data;
//   final String msg;
//   final ErrorType errorType;

//   CategoryState({
//     this.requestState = RequestState.initial,
//     this.data,
//     this.msg = '',
//     this.errorType = ErrorType.none,
//   });

//   CategoryState copyWith({
//     RequestState? requestState,
//     ModelsCategories? data,
//     String? msg,
//     ErrorType? errorType,
//   }) => CategoryState(
//     requestState: requestState ?? this.requestState,
//     data: data ?? this.data,
//     msg: msg ?? this.msg,
//     errorType: errorType ?? this.errorType,
//   );
// }

// class CategoryCubit extends Cubit<CategoryState> {
//   CategoryCubit() : super(CategoryState());

//   final LoginUsecase _categoryUseCase = LoginUseCaseImpl();

//   Future<void> fetchCategories() async {
//     // حالة التحميل
//     emit(
//       state.copyWith(
//         requestState: RequestState.loading,
//         msg: 'جاري تحميل التصنيفات...',
//       ),
//     );

//     final result = await _categoryUseCase.getCategories();

//     result.fold(
//       (failure) {
//         FlashHelper.showToast(failure.message, type: MessageTypeTost.fail);
//         emit(
//           state.copyWith(
//             requestState: RequestState.error,
//             msg: failure.message,
//             data: null,
//           ),
//         );
//         log('Error fetching categories: ${failure.message}');
//       },
//       (data) {
//         FlashHelper.showToast(
//           "تم تحميل التصنيفات بنجاح",
//           type: MessageTypeTost.success,
//         );
//         emit(
//           state.copyWith(
//             requestState: RequestState.done,
//             data: data,
//             msg: 'تم تحميل التصنيفات بنجاح',
//             errorType: ErrorType.none,
//           ),
//         );
//         log('Categories fetched successfully: ${data.items!.length} items');
//       },
//     );
//   }

//   // دالة مساعدة للتحقق من وجود بيانات
//   bool get hasData =>
//       state.data != null && state.requestState == RequestState.done;

//   // دالة مساعدة للتحقق من التحميل
//   bool get isLoading => state.requestState == RequestState.loading;

//   // دالة مساعدة للتحقق من الخطأ
//   bool get hasError => state.requestState == RequestState.error;
// }
