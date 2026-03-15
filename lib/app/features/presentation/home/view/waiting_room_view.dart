import 'package:berry_board/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:berry_board/app/features/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection_container.dart';
import '../../drawing/cubit/drawing_cubit.dart';
import '../../drawing/view/drawing_view.dart';
import '../widgets/waiting_room_body.dart';

class WaitingRoomView extends StatelessWidget {
  final String matchCode;
  const WaitingRoomView({super.key, required this.matchCode});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state.status == HomeStatus.roomJoined) {
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
      child: Scaffold(
        body: Center(child: WaitingRoomBody(matchCode: matchCode)),
      ),
    );
  }
}
