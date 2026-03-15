
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

import '../../../../common/constants/app_colors.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.drawingController,
  });

  final DrawingController drawingController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => drawingController
          .setPaintContent(SimpleLine()),
      icon: Icon(Icons.edit,color: AppColors.standardIconColor,),
    );
  }
}