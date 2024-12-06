import 'package:bloc_demo/core/errors/failure.dart';
import 'package:bloc_demo/src/authentication/domain/usecases/create_user.dart';
import 'package:bloc_demo/src/authentication/domain/usecases/get_users.dart';
import 'package:bloc_demo/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = ApiFailure(message: 'Server Failure', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('init state should be [AuthInit]', () {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('create user', () {
    blocTest<AuthenticationCubit, AuthenticationState>('should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUser(any())).thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParams.createdAt, name: tCreateUserParams.name, avatar: tCreateUserParams.avatar),
        expect: () => const [
              CreatingUser(),
              UserCreated(),
            ],
        verify: (_) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        }
        // act: (bloc) => bloc.add(const CreateUserEvent(createdAt: '2021-09-01', name: 'name', avatar: 'avatar')),
        );

    blocTest<AuthenticationCubit, AuthenticationState>('TODO: description',
        build: () {
          when(() => createUser(any())).thenAnswer((_) async => const Left(tAPIFailure));
          return cubit;
        },
        act: (cubit) {
          return cubit.createUser(
              createdAt: tCreateUserParams.createdAt, name: tCreateUserParams.name, avatar: tCreateUserParams.avatar);
        },
        expect: () => [const CreatingUser(), AuthenticationError(tAPIFailure.message)],
        verify: (_) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });
  
  group('get user', (){
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UsersLoaded([])
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      }
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, AuthenticationError] when unsuccessful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) async => await cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        AuthenticationError(tAPIFailure.message)
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      }
    );
  });
}
