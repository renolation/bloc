import 'package:bloc_reno/core/usecase/usecase.dart';
import 'package:bloc_reno/core/utils/typedefs.dart';

import '../repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repository);

  final OnBoardingRepo _repository;

  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}
