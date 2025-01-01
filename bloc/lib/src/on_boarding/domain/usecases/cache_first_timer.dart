import 'package:bloc_reno/core/usecase/usecase.dart';

import '../../../../core/utils/typedefs.dart';
import '../repos/on_boarding_repo.dart';

class CacheFirstTimer extends UseCaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepo _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
