import 'package:berry_board/app/features/presentation/drawing/cubit/drawing_cubit.dart';
import 'package:berry_board/app/features/presentation/drawing/cubit/drawing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../drawing/widgets/drawing_app_bar.dart';
import '../../drawing/widgets/drawing_body.dart';

class DrawingView extends StatelessWidget {
  const DrawingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DrawingCubit>().state.drawingController;
    return Scaffold(
      appBar: DrawingAppBar(),
      body: BlocListener<DrawingCubit, DrawingState>(
          child:  DrawingBody(drawingController: controller),
         listener: (BuildContext context, DrawingState state) { 
         },
      ),
    );
  }
}


