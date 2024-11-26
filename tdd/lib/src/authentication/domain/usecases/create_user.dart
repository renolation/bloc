
import 'package:bloc/core/usecase/usecase.dart';
import 'package:bloc/core/utils/typedef.dart';
import 'package:bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams>{
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
      createAt: params.createAt, name: params.name, avatar: params.avatar);

}

class CreateUserParams  extends Equatable {


  const CreateUserParams({required this.createAt, required this.name, required this.avatar});

  final String createAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createAt, name, avatar];
}