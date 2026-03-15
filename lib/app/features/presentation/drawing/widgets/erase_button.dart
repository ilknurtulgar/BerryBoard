import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

import '../../../../common/constants/app_colors.dart';

class EraseButton extends StatelessWidget {
  const EraseButton({
    super.key,
    required this.drawingController,
  });

  final DrawingController drawingController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          drawingController.setPaintContent(
            Eraser()
              ..paint = (Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 30.0
                ..color = AppColors.white),
          ),
      icon: Icon(Icons.cleaning_services,color: AppColors.standardIconColor,),
    );
  }
}
