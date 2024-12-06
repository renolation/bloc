import 'package:bloc_demo/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_demo/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:bloc_demo/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../src/authentication/data/repositories/authentication_repository_implementation.dart';
import '../../src/authentication/domain/usecases/create_user.dart';
import '../../src/authentication/domain/usecases/get_users.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
  //note: app logic
    ..registerFactory(() => AuthenticationCubit(createUser: sl(), getUsers: sl()))

    //note: use case
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    //note: repo
    ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImplementation(sl()))

    //note: data source
    ..registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthRemoteDataSrcImpl(client: sl()))

    //note: external dependencies
      ..registerLazySingleton(http.Client.new);
  
}
