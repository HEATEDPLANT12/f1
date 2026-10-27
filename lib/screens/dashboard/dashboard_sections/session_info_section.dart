import 'package:f1/providers/app/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../dashboard_widgets/dashboard_helpers.dart';

class SessionInfoSection extends ConsumerWidget {
  const SessionInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(teamProvider).tileColor;
    return dashboardCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashboardSectionLabel('SESSION INFO', color),
          const Divider(color: AppColors.divider),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: dashboardInfoItem(
                  context,
                  Icons.timer_outlined,
                  AppColors.purple,
                  'FASTEST LAP',
                  '1:16.421',
                  'L. Norris',
                ),
              ),
              dashboardVerticalDivider(context),
              Expanded(
                child: dashboardInfoItem(
                  context,
                  Icons.flag_outlined,
                  AppColors.green,
                  'TRACK STATUS',
                  'GREEN',
                  'All Clear',
                ),
              ),
              dashboardVerticalDivider(context),
              Expanded(
                child: dashboardInfoItem(
                  context,
                  Icons.speed_rounded,
                  AppColors.cyan,
                  'DRS',
                  'ENABLED',
                  '',
                ),
              ),
              dashboardVerticalDivider(context),
              Expanded(
                child: dashboardInfoItem(
                  context,
                  Icons.flag_rounded,
                  AppColors.yellow,
                  'FLAG STATUS',
                  'GREEN',
                  '',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
