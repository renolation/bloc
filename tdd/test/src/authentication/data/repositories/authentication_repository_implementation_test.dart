import 'package:bloc_test/core/errors/exceptions.dart';
import 'package:bloc_test/core/errors/failure.dart';
import 'package:bloc_test/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_test/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:bloc_test/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepoImpl extends Mock implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRepoImpl();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(message: 'Unknown error', statusCode: 500);
  const createdAt = '2021-09-01';
  const name = 'name';
  const avatar = 'avatar';
  group('createUser', () {

    test('test c', () async {
      //arrange
      when(
        () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenAnswer((_) async => Future.value());
      //act


      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(result, const Right(null));

      //assert
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });


    test('should return failure', () async {
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenThrow(tException
              );


      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
          result,
          equals( Left(
              ApiFailure(message: tException.message, statusCode: tException.statusCode))));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });


  group('get Users', (){

    test('should call get users and return list of users', () async {
      when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);
      final result = await repoImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return failure', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);
      
      final result = await repoImpl.getUsers();
      
      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
