import 'package:f1/providers/app/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../dashboard_widgets/dashboard_helpers.dart';
import '../dashboard_widgets/dashboard_responsive.dart';
import '../../../providers/race/session_provider.dart';
import '../../../providers/race/lap_provider.dart';

class CurrentSessionSection extends ConsumerWidget {
  const CurrentSessionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionProvider);
    final lapsAsync = ref.watch(lapProvider);
    //final color = ref.watch(teamColorProvider);

    return sessionsAsync.when(
      loading: () => dashboardCard(
        context,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => dashboardCard(
        context,
        child: Text(
          'Error:\n$error',
          style: TextStyle(
            color: AppColors.white,
            fontSize: responsiveFont(context, 14),
          ),
        ),
      ),
      data: (sessions) {
        if (sessions.isEmpty) {
          return dashboardCard(
            context,
            child: Text(
              'No session',
              style: TextStyle(
                color: AppColors.white,
                fontSize: responsiveFont(context, 14),
              ),
            ),
          );
        }

        final now = DateTime.now();

        final liveSessions = sessions.where(
          (session) {
            final start = DateTime.tryParse(session.dateStart);
            final end = DateTime.tryParse(session.dateEnd);

            if (start == null || end == null) return false;

            return !now.isBefore(start) && !now.isAfter(end);
          },

          /*orElse: () {
            final sorted = [...sessions]
              ..sort(
                (a, b) => DateTime.parse(
                  b.dateStart,
                ).compareTo(DateTime.parse(a.dateStart)),
              );
            return sorted.first;
          },*/
        ).toList();

        if (liveSessions.isEmpty) {
          return _buildNoLiveSessionCard(context, sessions);
        }

        final currentSession = liveSessions.first;
        return lapsAsync.when(
          loading: () => _buildCard(context, currentSession, null, ref),
          error: (_, _) => _buildCard(context, currentSession, null, ref),
          data: (laps) {
            final latestLap = laps.isEmpty
                ? null
                : laps.reduce((a, b) => a.lapNumber > b.lapNumber ? a : b);
            return _buildCard(
              context,
              currentSession,
              latestLap?.lapNumber,
              ref,
            );
          },
        );
      },
    );
  }

  Widget _buildCard(
    BuildContext context,
    dynamic session,
    int? lapNumber,
    WidgetRef ref,
  ) {
    const totalLaps = 57;

    final color = ref.watch(teamProvider).tileColor;

    final progress = lapNumber == null
        ? 0.0
        : (lapNumber / totalLaps).clamp(0.0, 1.0);

    return dashboardCard(
      context,
      backgroundImage: 'assets/images/teams/mclaren.svg',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashboardSectionLabel('CURRENT SESSION', color),
          const Divider(color: AppColors.divider),
          SizedBox(height: AppSpacing.md),
          /*Text(
            session.sessionName,
            style: TextStyle(
              color: AppColors.white,
              fontSize: responsiveFont(context, 23),
              fontWeight: FontWeight.w600,
            ),
          ),*/
          dashboardSessionBadge(session.sessionName),
          SizedBox(height: AppSpacing.sm),
          Text(
            '${session.circuitShortName}',
            style: TextStyle(
              color: AppColors.white70,
              fontSize: responsiveFont(context, 14),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            '${session.countryName}',
            style: TextStyle(
              color: AppColors.white70,
              fontSize: responsiveFont(context, 10),
            ),
          ),

          SizedBox(height: AppSpacing.lg),

          dashboardSessionMetric(
            context,
            'LAP',
            lapNumber == null ? '--/$totalLaps' : '$lapNumber / $totalLaps',
            accentFirst: true,
          ),

          /*Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              dashboardSessionBadge(session.sessionType),
              SizedBox(width: contextWidth(context, 0.045)),
              Expanded(
                child: dashboardSessionMetric(
                  context,
                  'LAP',
                  lapNumber == null
                      ? '--/$totalLaps'
                      : '$lapNumber / $totalLaps',
                  accentFirst: true,
                ),
              ),
            ],
          ),*/
          SizedBox(height: AppSpacing.md),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: contextHeight(context, 0.008),
              backgroundColor: AppColors.white54.withValues(alpha: 0.25),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),

          SizedBox(height: AppSpacing.xs),
          Text(
            '${(progress * 100).round()}% COMPLETED',
            style: TextStyle(
              color: AppColors.white54,
              fontSize: responsiveFont(context, 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoLiveSessionCard(BuildContext context, List sessions) {
    return dashboardCard(
      context,
      child: Text('Nothing to show', style: TextStyle(color: Colors.white)),
    );
  }
}

    

    /*return dashboardCard(
      context,
      child: Container(
        constraints: BoxConstraints(minHeight: contextHeight(context, 0.30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardSectionLabel('CURRENT SESSION'),
            const Divider(color: AppColors.divider),
            SizedBox(height: AppSpacing.md),
            Text(
              'Australian Grand Prix',
              style: TextStyle(
                color: AppColors.white,
                fontSize: responsiveFont(context, 23),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Text('🇦🇺'),
                SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    'Albert Park Circuit',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white70,
                      fontSize: responsiveFont(context, 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                dashboardSessionBadge('RACE'),
                SizedBox(width: contextWidth(context, 0.045)),
                Expanded(
                  child: dashboardSessionMetric(
                    context,
                    'LAP',
                    '24 / 57',
                    accentFirst: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.42,
                minHeight: contextHeight(context, 0.008),
                backgroundColor: AppColors.white54.withValues(alpha: 0.25),
                valueColor: const AlwaysStoppedAnimation(AppColors.orange),
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              '42% COMPLETED',
              style: TextStyle(
                color: AppColors.white54,
                fontSize: responsiveFont(context, 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/