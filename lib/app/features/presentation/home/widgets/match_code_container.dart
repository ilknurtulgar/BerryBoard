import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/widgets/textstyles/app_text.dart';

class MatchCodeContainer extends StatelessWidget {
  const MatchCodeContainer({
    super.key,
    required this.matchCode,
  });

  final String matchCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
      color: AppColors.darkBackgroundColor,
      borderRadius: BorderRadius.circular(30)
    ),child: AppText.title(matchCode,AppColors.white),);
  }
}