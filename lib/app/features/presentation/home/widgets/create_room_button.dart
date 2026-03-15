import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../../../../common/widgets/textstyles/app_text.dart';
import '../cubit/home_cubit.dart';

class CreateRoomButton extends StatelessWidget {
  const CreateRoomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeCubit>().createRoom();
      },
      child: AppText.title(
        AppStrings.createRoom,
        AppColors.titleTextColor,
      ),
    );
  }
}
