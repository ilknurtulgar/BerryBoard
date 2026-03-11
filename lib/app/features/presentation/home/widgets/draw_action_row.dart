import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/extensions/app_decorations_extensions.dart';

class DrawActionRow extends StatelessWidget {
  final DrawingController drawingController;
  const DrawActionRow({
    super.key, required this.drawingController
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: AppDecorations.boardStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => drawingController
                .setPaintContent(SimpleLine()),
            icon: Icon(Icons.edit,color: AppColors.standardIconColor,),
          ),
          IconButton(
            onPressed: () =>
                drawingController.setPaintContent(
                  Eraser()
                    ..paint = (Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 30.0
                      ..color = AppColors.white),
                ),
            icon: Icon(Icons.cleaning_services,color: AppColors.standardIconColor,),
          ),
          IconButton(
            onPressed: () => drawingController.clear(),
            icon: Icon(Icons.delete,color: AppColors.removeColor,),
          ),
        ],
      ),
    );
  }
}