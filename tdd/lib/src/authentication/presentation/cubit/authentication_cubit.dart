import 'package:bloc/bloc.dart';
import 'package:bloc_demo/core/errors/failure.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      ),
    );
    result.fold(
        (l) => emit(AuthenticationError('${l.statusCode} Error: ${l.message}')),
        (r) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold(
        (l) => emit(AuthenticationError('${l.statusCode} Error: ${l.message}')),
        (r) => emit(UsersLoaded(r)));
  }
}
