import 'package:berry_board/app/features/presentation/home/cubit/drawing_cubit.dart';
import 'package:berry_board/app/features/presentation/home/cubit/drawing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_app_bar.dart';
import '../widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final String roomId = "test_odasi_123";

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DrawingCubit>().state.drawingController;
    return Scaffold(
      appBar: HomeAppBar(),
      body: BlocListener<DrawingCubit, DrawingState>(
          child:  HomeBody(drawingController: controller),
         listener: (BuildContext context, DrawingState state) { 
          
         },
      ),
    );
  }
}


