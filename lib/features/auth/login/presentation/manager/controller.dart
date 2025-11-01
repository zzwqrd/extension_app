import 'package:extension_app/core/utils/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../data/models/model.dart';
import '../../domain/usecases/login_usecase.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final LoginUsecase _loginUseCase = LoginUseCaseImpl();
  final formKey = GlobalKey<FormState>();

  LoginModel loginModel = LoginModel(
    email: "user@alicom.com".trim(),
    password: "secret".trim(),
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
        FlashHelper.showToast(r.message, type: MessageTypeTost.success);
        emit(state.copyWith(requestState: RequestState.done));
      },
    );
  }
}
