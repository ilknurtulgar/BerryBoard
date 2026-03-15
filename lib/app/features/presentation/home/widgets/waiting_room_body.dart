import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../../../../common/widgets/textstyles/app_text.dart';
import 'match_code_container.dart';

class WaitingRoomBody extends StatelessWidget {
  const WaitingRoomBody({
    super.key,
    required this.matchCode,
  });

  final String matchCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText.header(AppStrings.shareTheCodeInfo, AppColors.headerTextColor),
        Gap(100),
        MatchCodeContainer(matchCode: matchCode),
        Gap(40),
        AppText.body(AppStrings.matchInfo, AppColors.black)
      ],
    );
  }
}

