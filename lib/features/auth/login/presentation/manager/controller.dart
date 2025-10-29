import 'package:extension_app/core/utils/flash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../data/models/model.dart';
import '../../domain/usecases/login_usecase.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final _loginUseCase = LoginUsecase();

  Future<void> login(String email, String password) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final loginModel = LoginModel(email: email, password: password);
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
