import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/model.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _loginUseCase = LoginUsecase();
  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final loginModel = LoginModel(email: email, password: password);
    final result = await _loginUseCase(loginModel);

    result.fold(
      (l) => emit(LoginError(l.message)),
      (r) => emit(LoginSuccess(r.data)),
    );
  }
}
