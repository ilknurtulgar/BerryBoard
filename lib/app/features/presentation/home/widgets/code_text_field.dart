import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_strings.dart';
import '../cubit/home_cubit.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: TextField(
        maxLength: 6,
        controller: context
            .read<HomeCubit>()
            .getTextEditingController,
        onChanged: (value) =>
            context.read<HomeCubit>().onChangedValue(value),
        keyboardType: TextInputType.number,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          hintText: AppStrings.partnerCode,
          hintStyle: TextStyle(color: AppColors.white),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.shadowColor,
              width: 1,
            ),
          ),
          fillColor: AppColors.darkBackgroundColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.shadowColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
