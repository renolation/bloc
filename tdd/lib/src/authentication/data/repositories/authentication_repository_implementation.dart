import 'package:bloc/core/errors/exceptions.dart';
import 'package:bloc/core/utils/typedef.dart';
import 'package:bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';

import 'package:bloc/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {

  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  final AuthenticationRemoteDataSource _remoteDataSource;


  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async{
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch(e){
      return Left(ApiFailure.fromException(e));
    }
  }
}
