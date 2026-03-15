import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

import '../../../../common/extensions/app_decorations_extensions.dart';
import 'clear_button.dart';
import 'edit_button.dart';
import 'erase_button.dart';

class DrawActionRow extends StatelessWidget {
  final DrawingController drawingController;
  const DrawActionRow({super.key, required this.drawingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: AppDecorations.boardStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          EditButton(drawingController: drawingController),
          EraseButton(drawingController: drawingController),
          ClearButton(drawingController: drawingController),
        ],
      ),
    );
  }
}
