import 'package:bloc_reno/core/errors/failures.dart';
import 'package:bloc_reno/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:bloc_reno/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:bloc_reno/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CheckIfUserIsFirstTimer useCase;

  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CheckIfUserIsFirstTimer(repo);
  });

  test('should call the [OnBoardingRepo.checkIfUserIsFirstTimer] ', () async {
    when(() => repo.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => const Right(true));

    final result = await useCase();

    expect(result, equals(const Right<Failure, dynamic>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test(
      'should call the [OnBoardingRepo.checkIfUserIsFirstTimer '
          'and return the right data', () async {
    when(() => repo.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => Left(ServerFailure(message: 'Server Failure', statusCode: 500)));
    final result = await useCase();

    expect(result, equals(Left<Failure, dynamic>(ServerFailure(message: 'Server Failure', statusCode: 500))));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
