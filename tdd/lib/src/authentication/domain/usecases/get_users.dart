

import 'package:bloc_demo/core/usecase/usecase.dart';
import 'package:bloc_demo/core/utils/typedef.dart';
import 'package:bloc_demo/src/authentication/domain/entities/user.dart';

import '../repositories/authentication_repository.dart';

class GetUsers  extends UseCaseWithoutParams<List<User>> {
  const GetUsers(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}