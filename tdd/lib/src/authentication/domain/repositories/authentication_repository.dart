import 'package:bloc/core/errors/failure.dart';
import 'package:bloc/core/utils/typedef.dart';
import 'package:bloc/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser(
      {required String createdAt, required String name, required String avatar});

  ResultFuture<List<User>> getUsers();
}
