import 'package:bloc_demo/src/authentication/domain/entities/user.dart';
import 'package:bloc_demo/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:bloc_demo/src/authentication/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCase = GetUsers(repository);
  });

  const tResponse = [User.empty()];
  
  test('should call AuthRepo.getUsers then return list users', () async {
    when(() => repository.getUsers()).thenAnswer((_) async => const Right(tResponse));

  final result = await useCase();
  
  expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

  verify(() => repository.getUsers()).called(1);
  verifyNoMoreInteractions(repository);
  });
}