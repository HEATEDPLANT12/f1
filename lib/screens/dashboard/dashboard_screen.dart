import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/team.dart';
import '../../core/constants/app_spacing.dart';
import 'dashboard_sections/current_session_section.dart';
import 'dashboard_sections/next_session_section.dart';
import 'dashboard_sections/session_info_section.dart';
import 'dashboard_sections/team_status_section.dart';
import 'dashboard_sections/weather_strategy_section.dart';
import 'dashboard_widgets/dashboard_responsive.dart';

class DashboardScreen extends ConsumerWidget {
  final Team team;

  const DashboardScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final backcolor = ref.watch(teamProvider).accentColor;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: contextWidth(context, 0.045),
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //DashboardHeader(team: team),
                //SizedBox(height: AppSpacing.md),
                //DashboardTeamSelector(team: team),
                //SizedBox(height: AppSpacing.md),
                IconButton(
                  onPressed: () {
                    context.go('/team_selection');
                  },
                  icon: const Icon(
                    Icons.swap_horiz_rounded,
                    color: Colors.white,
                  ),
                ),
                const CurrentSessionSection(),
                SizedBox(height: AppSpacing.md),
                const TeamStatusSection(),
                SizedBox(height: AppSpacing.md),
                const SessionInfoSection(),
                SizedBox(height: AppSpacing.md),
                const WeatherStrategySection(),
                SizedBox(height: AppSpacing.md),
                const NextSessionSection(),
                SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
