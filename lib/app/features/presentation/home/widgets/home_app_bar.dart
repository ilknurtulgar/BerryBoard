import 'package:berry_board/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/app_strings.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(AppStrings.appBarTitle,style: TextStyle(color: AppColors.headerTextColor,
      fontWeight: FontWeight.w500,
       fontSize: 24),),
      backgroundColor: AppColors.transparent,
      elevation: 0,
    );
  }
  

}
