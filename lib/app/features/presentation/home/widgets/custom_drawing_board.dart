import 'package:berry_board/app/features/presentation/home/cubit/drawing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/extensions/app_decorations_extensions.dart';

class CustomDrawingBoard extends StatelessWidget {
  final DrawingController drawingController;
  const CustomDrawingBoard({super.key, required this.drawingController});

  @override
  Widget build(BuildContext context) {
    final double boardSize = MediaQuery.of(context).size.width * 1.2;

    return Container(
      width: boardSize,
      height: boardSize,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: AppDecorations.boardStyle(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: DrawingBoard(
          maxScale: 1.0,
          minScale: 1.0,
          background: Container(
            width: boardSize,
            height: boardSize,
            decoration: BoxDecoration(color: AppColors.white),
          ),
          controller: drawingController,
          onPointerUp: (event) {
            final history = drawingController.getHistory;
            if(history.isNotEmpty){
              context.read<DrawingCubit>().onDrawingFinished(history.last);
            }
          },
        ),
      ),
    );
  }
}
