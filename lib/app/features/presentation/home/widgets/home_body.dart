import 'package:berry_board/app/features/presentation/home/widgets/create_room_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../../../../common/widgets/textstyles/app_text.dart';
import 'code_text_field.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.header(
            AppStrings.takeTheCodeInfo,
            AppColors.headerTextColor,
          ),
          Gap(100),
          CodeTextField(),
          Gap(60),
          CreateRoomButton(),
        ],
      ),
    );
  }
}
