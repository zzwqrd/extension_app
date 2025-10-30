import 'package:dartz/dartz.dart';

import '../../../../../core/services/helper_respons.dart';
import '../../data/models/model.dart';
import '../../data/models/model_e.dart';

abstract class LoginRepository {
  Future<Either<HelperResponse, GetDataUserModel>> login(LoginModel loginModel);
}
