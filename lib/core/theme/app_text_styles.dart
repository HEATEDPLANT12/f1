import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const heading = TextStyle(
    color: AppColors.white,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const title = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const body = TextStyle(color: AppColors.white70, fontSize: 14);

  static const caption = TextStyle(color: AppColors.white54, fontSize: 12);

  static TextStyle section(Color color) => TextStyle(
    color: color,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
  );
}
