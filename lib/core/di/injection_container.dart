import 'package:berry_board/app/features/data/datasources/auth_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/drawing_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/local_storage_datasource.dart';
import 'package:berry_board/app/features/data/datasources/user_remote_data_source.dart';
import 'package:berry_board/app/features/data/repositories/drawing_stroke_repository_impl.dart';
import 'package:berry_board/app/features/data/repositories/user_repository_impl.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';
import 'package:berry_board/app/features/domain/usecases/auth/complete_on_boarding_use_case.dart';
import 'package:berry_board/app/features/domain/usecases/auth/get_initial_route_use_case.dart';
import 'package:berry_board/app/features/domain/usecases/drawing/send_stroke_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/drawing/watch_canvas_usecase.dart';
import 'package:berry_board/app/features/presentation/home/cubit/drawing_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/features/domain/repositories/drawing_stroke_repository.dart';
import '../../app/features/presentation/splash/cubit/splash_cubit.dart';


final getIt = GetIt.instance;

Future<void> init()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(()=> sharedPreferences);

  //datasources
  getIt.registerLazySingleton<ILocalStorageDataSource>(()=> LocalStorageDatasourceImpl(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<IDrawingRemoteDataSource>(() => DrawingRemoteDataSourceImpl());
  getIt.registerLazySingleton<IAuthRemoteDataSource>(()=> AuthRemoteDataSourceImpl());
  getIt.registerLazySingleton<IUserRemoteDataSource>(()=> UserRemoteDataSourceImpl());

  //repositories
  getIt.registerLazySingleton<IDrawingStrokeRepository>(()=> DrawingStrokeRepositoryImpl(getIt()));
  getIt.registerLazySingleton<IUserRepository>(()=> UserRepositoryImpl(authDataSource: getIt(), userDataSource: getIt()));

  //usecases
  getIt.registerLazySingleton(()=> GetInitialRouteUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(()=> CompleteOnBoardingUseCase(getIt()));
  getIt.registerLazySingleton(()=> WatchCanvasUsecase(getIt()));
  getIt.registerLazySingleton(()=> SendStrokeUsecase(getIt()));

  //cubits
  getIt.registerFactory(()=> SplashCubit(getIt()));
  getIt.registerFactory(()=> DrawingCubit(watchCanvasUsecase: getIt(),
  sendStrokeUsecase: getIt()));
}