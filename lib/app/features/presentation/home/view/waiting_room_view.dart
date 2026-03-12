import 'package:berry_board/app/common/widgets/textstyles/app_text.dart';
import 'package:berry_board/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:berry_board/app/features/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../../drawing/cubit/drawing_cubit.dart';
import '../../drawing/view/drawing_view.dart';

class WaitingRoomView extends StatelessWidget {
  final String matchCode;
  const WaitingRoomView({super.key, required this.matchCode});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
    listener: (BuildContext context, HomeState state) { 
      if(state.status == HomeStatus.roomJoined){
        Navigator.pushReplacement(
            context, 
         MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (context) => getIt<DrawingCubit>()..initialize(),
      child: const DrawingView(),
    ),));
      }
     },
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            AppText.header(AppStrings.shareTheCodeInfo, AppColors.headerTextColor),
            Gap(100),
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
              color: AppColors.darkBackgroundColor,
              borderRadius: BorderRadius.circular(30)
            ),child: AppText.title(matchCode,AppColors.white),),
            Gap(40),
            AppText.body(AppStrings.matchInfo, AppColors.black)
          ],
        ),
      ),
    ));
  }
}