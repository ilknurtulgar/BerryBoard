import 'package:berry_board/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:berry_board/app/features/presentation/splash/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_container.dart';
import '../../features/presentation/drawing/cubit/drawing_cubit.dart';

class AppProviders {
  AppProviders._();

  static List<BlocProvider> get providers => [
    BlocProvider<SplashCubit>(create: (context) => getIt<SplashCubit>()),
    BlocProvider<DrawingCubit>(create: (context) => getIt<DrawingCubit>()),
    BlocProvider<HomeCubit>(create: (contex) => getIt<HomeCubit>())
  ];
}
