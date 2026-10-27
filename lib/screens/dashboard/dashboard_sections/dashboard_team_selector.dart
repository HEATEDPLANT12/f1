import 'package:flutter/material.dart';

import '../../../models/team.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../dashboard_widgets/dashboard_responsive.dart';

class DashboardTeamSelector extends StatelessWidget {
  final Team team;

  const DashboardTeamSelector({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: contextWidth(context, 0.045),
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                team.name,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: responsiveFont(context, 15),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.white70,
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: contextWidth(context, 0.035),
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.green.withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: contextWidth(context, 0.022),
                height: contextWidth(context, 0.022),
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                'LIVE',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: responsiveFont(context, 14),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
