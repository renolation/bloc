
import 'package:bloc_reno/core/usecase/usecase.dart';
import 'package:bloc_reno/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../entities/user.dart';
import '../repos/auth_repo.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams>{
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) async => _repo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
      );
}


class SignUpParams extends Equatable{
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty()
      : email = '',
        password = '',
        fullName = '';

  final String email;
  final String password;
  final String fullName;

  @override
  List<String> get props => [email, password, fullName];
}