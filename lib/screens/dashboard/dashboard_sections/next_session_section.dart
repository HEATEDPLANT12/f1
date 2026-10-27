import 'package:f1/providers/app/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../dashboard_widgets/dashboard_helpers.dart';
import '../dashboard_widgets/dashboard_responsive.dart';
import '../../../providers/race/session_provider.dart';

class NextSessionSection extends ConsumerWidget {
  const NextSessionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(teamProvider).tileColor;
    final sessionsAsync = ref.watch(sessionProvider);

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
            fontSize: responsiveFont(context, 13),
          ),
        ),
      ),
      data: (sessions) {
        final now = DateTime.now();

        final upcoming = sessions.where((session) {
          final start = DateTime.tryParse(session.dateStart);

          return start != null && start.isAfter(now);
        }).toList();

        upcoming.sort(
          (a, b) => DateTime.parse(
            a.dateStart,
          ).compareTo(DateTime.parse(b.dateStart)),
        );

        final nextSessions = upcoming.take(3).toList();

        return dashboardCard(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dashboardSectionLabel('NEXT SESSION', color),
              const Divider(color: AppColors.divider),
              SizedBox(height: AppSpacing.sm),

              if (nextSessions.isEmpty)
                _emptyState(context)
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < nextSessions.length; i++) ...[
                      Expanded(
                        child: Center(
                          child: _nextSessionItem(context, nextSessions[i]),
                        ),
                      ),
                      if (i < nextSessions.length - 1)
                        Padding(
                          padding: EdgeInsets.only(
                            left: AppSpacing.md,
                            right: AppSpacing.md,
                            top: contextHeight(context, 0.035),
                          ),
                          //child: dashboardDashedLine(context),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.white,
                            size: contextWidth(context, 0.065),
                          ),
                        ),
                    ],
                  ],
                ),
            ],
          ),
        );
      },
    );

    /*return dashboardCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashboardSectionLabel('NEXT SESSION', color),
          const Divider(color: AppColors.divider),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: dashboardNextSessionItem(
                  context,
                  Icons.timer_outlined,
                  AppColors.purple,
                  'PRACTICE 3',
                  'TOMORROW',
                  '12:30 PM',
                ),
              ),
              dashboardDashedLine(context),
              Expanded(
                child: dashboardNextSessionItem(
                  context,
                  Icons.schedule_rounded,
                  AppColors.orange,
                  'QUALIFYING',
                  'TOMORROW',
                  '4:00 PM',
                ),
              ),
              dashboardDashedLine(context),
              Expanded(
                child: dashboardNextSessionItem(
                  context,
                  Icons.flag_rounded,
                  AppColors.red,
                  'RACE',
                  'SUNDAY',
                  '3:00 PM',
                ),
              ),
            ],
          ),
        ],
      ),
    );*/
  }

  Widget _nextSessionItem(BuildContext context, dynamic session) {
    final date = DateTime.parse(session.dateStart).toLocal();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          _sessionIcon(session.sessionType),
          color: _sessionColor(session.sessionType),
          size: contextWidth(context, 0.07),
        ),
        SizedBox(height: AppSpacing.sm),

        SizedBox(
          height: responsiveFont(context, 11) * 1.2,
          child: Text(
            session.sessionName.toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.white,
              fontSize: responsiveFont(context, 11),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(height: AppSpacing.xs),
        Text(
          _dayLabel(date),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white54,
            fontSize: responsiveFont(context, 9),
          ),
        ),
        Text(
          _timeLabel(date),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white70,
            fontSize: responsiveFont(context, 9),
          ),
        ),
      ],
    );
  }

  IconData _sessionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'race':
        return Icons.flag_rounded;
      case 'qualifying':
        return Icons.schedule_rounded;
      default:
        return Icons.timer_outlined;
    }
  }

  Color _sessionColor(String type) {
    switch (type.toLowerCase()) {
      case 'race':
        return AppColors.red;
      case 'qualifying':
        return AppColors.orange;
      default:
        return AppColors.purple;
    }
  }

  String _dayLabel(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final sessionDay = DateTime(date.year, date.month, date.day);

    final difference = sessionDay.difference(today).inDays;

    if (difference == 0) return 'TODAY';
    if (difference == 1) return 'TOMORROW';

    const days = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];

    return days[date.weekday - 1];
  }

  String _timeLabel(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
        ? date.hour - 12
        : date.hour;

    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  Widget _emptyState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Center(
        child: Text(
          'nothing',
          style: TextStyle(
            color: AppColors.white54,
            fontSize: responsiveFont(context, 12),
          ),
        ),
      ),
    );
  }
}
