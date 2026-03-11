import 'package:berry_board/app/common/constants/app_colors.dart';
import 'package:berry_board/app/features/domain/usecases/auth/complete_on_boarding_use_case.dart';
import 'package:berry_board/app/features/presentation/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/di/injection_container.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("OnBoarding view", style: TextStyle(fontSize: 30,color: AppColors.headerTextColor)),
            Gap(50),
            ElevatedButton(onPressed: () async{
              await getIt<CompleteOnBoardingUseCase>().call();
              if(context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeView()));
              }
            }, child: Text("Start")),
          ],
        ),
      ),
    );
  }
}
