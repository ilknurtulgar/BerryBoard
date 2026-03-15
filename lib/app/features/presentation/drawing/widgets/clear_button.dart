import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

import '../../../../common/constants/app_colors.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
    required this.drawingController,
  });

  final DrawingController drawingController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => drawingController.clear(),
      icon: Icon(Icons.delete,color: AppColors.removeColor,),
    );
  }
}

