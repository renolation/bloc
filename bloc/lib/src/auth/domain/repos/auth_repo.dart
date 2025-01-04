import 'package:bloc_reno/core/enums/update_user.dart';

import 'package:bloc_reno/core/utils/typedefs.dart';
import 'package:bloc_reno/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
