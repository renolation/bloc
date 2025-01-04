
import 'package:bloc_reno/core/enums/update_user.dart';
import 'package:bloc_reno/src/auth/domain/entities/user.dart';
import 'package:bloc_reno/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_reno/core/usecase/usecase.dart';
import 'package:bloc_reno/core/utils/typedefs.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthRepo _repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) async => _repository.updateUser(
    action: params.action,
    userData: params.userData,
  );
}


class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  const UpdateUserParams.empty()
      : action = UpdateUserAction.displayName,
        userData = null;

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}