import 'package:bloc_reno/core/errors/failures.dart';
import 'package:bloc_reno/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:bloc_reno/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer useCase;

  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CacheFirstTimer(repo);
  });

  test(
      'should call the [OnBoardingRepo.cacheFirstTimer '
      'and return the right data', () async {
    when(() => repo.cacheFirstTimer())
        .thenAnswer((_) async => Left(ServerFailure(message: 'Server Failure', statusCode: 500)));
    final result = await useCase();

    expect(result, equals(Left<Failure, dynamic>(ServerFailure(message: 'Server Failure', statusCode: 500))));
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
