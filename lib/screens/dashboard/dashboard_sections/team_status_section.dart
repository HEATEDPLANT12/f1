import 'package:f1/providers/app/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../dashboard_widgets/dashboard_helpers.dart';
import '../dashboard_widgets/dashboard_responsive.dart';

class TeamStatusSection extends ConsumerWidget {
  const TeamStatusSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(teamProvider).tileColor;

    return dashboardCard(
      context,
      child: Column(
        children: [
          dashboardSectionHeader(context, 'TEAM STATUS', 'VIEW DRIVERS', color),
          const Divider(color: AppColors.divider),
          SizedBox(height: AppSpacing.sm),
          _driverCard(
            context,
            number: '4',
            name: 'NORRIS',
            position: 'P1',
            tyre: 'MEDIUM',
          ),
          SizedBox(height: AppSpacing.sm),
          _driverCard(
            context,
            number: '81',
            name: 'PIASTRI',
            position: 'P3',
            tyre: 'MEDIUM',
          ),
        ],
      ),
    );
  }

  Widget _driverCard(
    BuildContext context, {
    required String number,
    required String name,
    required String position,
    required String tyre,
  }) {
    return Container(
      padding: EdgeInsets.all(contextWidth(context, 0.035)),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: TextStyle(
              color: AppColors.orange,
              fontSize: responsiveFont(context, 28),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: contextWidth(context, 0.035)),
          Container(
            width: contextWidth(context, 0.13),
            height: contextWidth(context, 0.13),
            decoration: BoxDecoration(
              color: AppColors.orange.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.orange.withValues(alpha: 0.8),
              size: contextWidth(context, 0.075),
            ),
          ),
          SizedBox(width: contextWidth(context, 0.035)),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: responsiveFont(context, 14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  position,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: responsiveFont(context, 20),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          dashboardVerticalDivider(context),
          Expanded(flex: 2, child: dashboardSmallMetric(context, 'TYRE', tyre)),
          SizedBox(width: AppSpacing.sm),
          dashboardTyreIcon(context),
        ],
      ),
    );
  }
}
