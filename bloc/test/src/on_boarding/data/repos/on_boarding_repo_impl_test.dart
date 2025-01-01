import 'package:bloc_reno/core/errors/exceptions.dart';
import 'package:bloc_reno/core/errors/failures.dart';
import 'package:bloc_reno/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:bloc_reno/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:bloc_reno/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repo;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repo = OnBoardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnBoardingRepo', () async {
    expect(repo, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test('should complete successfully when call to local source is successful', () async {
      when(() => localDataSource.cacheFirstTimer()).thenAnswer((_) async => Future.value());
      final result = await repo.cacheFirstTimer();
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return [CacheFailure] when call to local source is unsuccessful', () async {
      when(() => localDataSource.cacheFirstTimer()).thenThrow(const CacheException(message: 'Insufficient storage'));
      final result = await repo.cacheFirstTimer();
      expect(result, equals(Left<CacheFailure, void>(CacheFailure(message: 'Insufficient storage', statusCode: 500))));
      verify(() => localDataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
