import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

extension AppDecorations on BoxDecoration {
  static BoxDecoration boardStyle(){
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowColor,
          blurRadius: 10,
          spreadRadius: 2,
          offset: Offset.zero,
        ),
      ],
    );
  }
}