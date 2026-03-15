import 'package:berry_board/app/common/constants/app_strings.dart';
import 'package:berry_board/app/common/widgets/dialogs/info_alert_dialog.dart';
import 'package:berry_board/app/features/presentation/drawing/cubit/drawing_cubit.dart';
import 'package:berry_board/app/features/presentation/drawing/view/drawing_view.dart';
import 'package:berry_board/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:berry_board/app/features/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection_container.dart';
import '../widgets/home_body.dart';
import 'waiting_room_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state.status == HomeStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => getIt<DrawingCubit>()..initialize(),
                child: const DrawingView(),
              ),
            ),
          );
        } else if (state.status == HomeStatus.error) {
          InfoAlertDiaolog.show(
            context,
            state.errorMessage ?? AppStrings.error,
          );
          context.read<HomeCubit>().clearController();
        } else if (state.generatedCode != null &&
            state.status == HomeStatus.initial) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<HomeCubit>(),
                child: WaitingRoomView(matchCode: state.generatedCode!),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: HomeBody(),
      ),
    );
  }
}



