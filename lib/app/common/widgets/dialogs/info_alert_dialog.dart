import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../textstyles/app_text.dart';

class InfoAlertDiaolog extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;
  const InfoAlertDiaolog({super.key, required this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText.title(message, AppColors.black),
      actions: [
        TextButton(
          onPressed: onPressed ?? () => Navigator.pop(context),
          child: AppText.body(AppStrings.okay, AppColors.darkBackgroundColor),
        ),
      ],
    );
  }

  static Future<void> show(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => InfoAlertDiaolog(message: message),
    );
  }
}