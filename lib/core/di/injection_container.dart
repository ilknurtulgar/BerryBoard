import 'package:berry_board/app/features/data/datasources/auth_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/drawing_remote_data_source.dart';
import 'package:berry_board/app/features/data/datasources/local_storage_datasource.dart';
import 'package:berry_board/app/features/data/datasources/match_data_source.dart';
import 'package:berry_board/app/features/data/datasources/user_remote_data_source.dart';
import 'package:berry_board/app/features/data/repositories/drawing_stroke_repository_impl.dart';
import 'package:berry_board/app/features/data/repositories/match_repository_impl.dart';
import 'package:berry_board/app/features/data/repositories/user_repository_impl.dart';
import 'package:berry_board/app/features/domain/repositories/match_repository.dart';
import 'package:berry_board/app/features/domain/repositories/user_repository.dart';
import 'package:berry_board/app/features/domain/usecases/auth/complete_on_boarding_use_case.dart';
import 'package:berry_board/app/features/domain/usecases/auth/get_initial_route_use_case.dart';
import 'package:berry_board/app/features/domain/usecases/drawing/send_stroke_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/drawing/watch_canvas_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/match/create_match_and_get_code_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/match/join_room_usecase.dart';
import 'package:berry_board/app/features/domain/usecases/match/watch_match_usecase.dart';
import 'package:berry_board/app/features/presentation/drawing/cubit/drawing_cubit.dart';
import 'package:berry_board/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/features/domain/repositories/drawing_stroke_repository.dart';
import '../../app/features/presentation/splash/cubit/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //datasources
  getIt.registerLazySingleton<ILocalStorageDataSource>(
    () => LocalStorageDatasourceImpl(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<IDrawingRemoteDataSource>(
    () => DrawingRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<IMatchDataSource>(
    () => MatchDataSourceImpl(getIt<FirebaseFirestore>()),
  );

  //repositories
  getIt.registerLazySingleton<IDrawingStrokeRepository>(
    () => DrawingStrokeRepositoryImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepositoryImpl(authDataSource: getIt(), userDataSource: getIt()),
  );
  getIt.registerLazySingleton<IMatchRepository>(
    () => MatchRepositoryImpl(
      matchDataSource: getIt(),
      authDataSource: getIt(),
      userRemoteDataSource: getIt(),
    ),
  );
  //usecases
  getIt.registerLazySingleton(() => GetInitialRouteUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => CompleteOnBoardingUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchCanvasUsecase(getIt()));
  getIt.registerLazySingleton(() => SendStrokeUsecase(getIt()));
  getIt.registerLazySingleton(() => JoinRoomUsecase(getIt()));
  getIt.registerLazySingleton(() => CreateMatchAndGetCodeUsecase(getIt()));
  getIt.registerLazySingleton(() => WatchMatchUsecase(getIt()));

  //cubits
  getIt.registerFactory(() => SplashCubit(getIt()));
  getIt.registerFactory(
    () => DrawingCubit(
      watchCanvasUsecase: getIt(),
      sendStrokeUsecase: getIt(),
      currentUid: getIt<IAuthRemoteDataSource>().currentUid ?? "unknown",
    ),
  );
  getIt.registerFactory(() => HomeCubit(getIt(), getIt(), getIt()));
}
