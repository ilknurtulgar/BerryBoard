import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset.zero,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(AppStrings.logoPath, fit: BoxFit.cover),
      ),
    );
  }
}
