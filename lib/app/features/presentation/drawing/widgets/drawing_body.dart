import 'package:berry_board/app/features/presentation/drawing/widgets/draw_action_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:gap/gap.dart';

import 'custom_drawing_board.dart';

class DrawingBody extends StatelessWidget {
  final DrawingController drawingController;
  const DrawingBody({super.key, required this.drawingController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Gap(30),
            CustomDrawingBoard(drawingController: drawingController),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 70,
          child: Center(
            child: DrawActionRow(drawingController: drawingController),
          ),
        ),
      ],
    );
  }
}
