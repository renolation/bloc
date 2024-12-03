import 'package:bloc_test/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:bloc_test/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';


void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();


  test("should call", () async {
    //arrange
    //stub
    when(() =>
        repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'))).thenAnswer((_) async =>
    const Right(null));
    //act
    final result = useCase(params);
    //assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(repository);

  });
}
