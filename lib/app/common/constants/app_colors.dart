import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static final Color? backgroundColor = Colors.pink[50];
  static final Color transparent = Colors.transparent;

  static final Color?  headerTextColor = Colors.pink[800];
  static final Color? titleTextColor = Colors.pink[400];
  static Color? standardIconColor = Colors.pink[400];
  static const Color removeColor = Colors.redAccent; 
  static final shadowColor = Colors.pink.withValues(alpha: 0.1);
  static final hintTextColor = Colors.grey.withValues(alpha: 0.1);
  static final Color? darkBackgroundColor = Colors.pink[500];
  
}