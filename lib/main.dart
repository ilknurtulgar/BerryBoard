import 'package:berry_board/app/common/constants/app_colors.dart';
import 'package:berry_board/app/common/constants/provider_list.dart';
import 'package:berry_board/app/features/presentation/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';


void main() async  {
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.providers,
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor),
        debugShowCheckedModeBanner: false,
        home: SplashView()
      ),
    );
  }
}
