import 'package:bloc_reno/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:bloc_reno/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:bloc_reno/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:bloc_reno/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:bloc_reno/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  //Features - Authentication
  //Business Logic
  sl
    ..registerFactory(() => OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()))
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSrcImpl(sl()))
    ..registerLazySingleton(() => prefs);
}
