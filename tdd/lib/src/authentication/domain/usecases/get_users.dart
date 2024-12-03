

import 'package:bloc_test/core/usecase/usecase.dart';
import 'package:bloc_test/core/utils/typedef.dart';
import 'package:bloc_test/src/authentication/domain/entities/user.dart';

import '../repositories/authentication_repository.dart';

class GetUsers  extends UseCaseWithoutParams<List<User>> {
  const GetUsers(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}