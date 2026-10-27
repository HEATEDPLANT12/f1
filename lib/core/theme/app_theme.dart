import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
    ),

    cardColor: AppColors.card,

    dividerColor: AppColors.divider,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.orange,
      secondary: AppColors.green,
      surface: AppColors.card,
    ),
  );
}
