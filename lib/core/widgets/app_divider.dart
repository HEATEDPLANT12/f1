import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.divider, thickness: 1, height: 1);
  }
}
