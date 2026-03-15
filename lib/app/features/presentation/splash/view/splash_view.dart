import 'package:berry_board/app/features/presentation/drawing/view/drawing_view.dart';
import 'package:berry_board/app/features/presentation/onboarding/views/on_boarding_view.dart';
import 'package:berry_board/app/features/presentation/splash/cubit/splash_cubit.dart';
import 'package:berry_board/app/features/presentation/splash/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection_container.dart';
import '../../drawing/cubit/drawing_cubit.dart';
import '../../home/view/home_view.dart';
import '../widgets/splash_logo.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.onboarding) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnBoardingView()),
          );
        } else if (state.status == SplashStatus.home) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        } else if (state.status == SplashStatus.error) {
          debugPrint("error: ${state.errorMessage}");
        } else if (state.status == SplashStatus.drawing) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => getIt<DrawingCubit>()..initialize(),
                child: const DrawingView(),
              ),
            ),
          );
        }
      },
      child: Scaffold(body: Center(child: SplashLogo())),
    );
  }
}
