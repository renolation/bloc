import 'package:bloc_reno/core/usecase/usecase.dart';
import 'package:bloc_reno/src/auth/domain/repos/auth_repo.dart';

import '../../../../core/utils/typedefs.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) async => _repo.forgotPassword(params);
}
