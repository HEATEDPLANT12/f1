import 'package:f1/providers/app/team_provider.dart';
import 'package:f1/providers/weather/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../dashboard_widgets/dashboard_helpers.dart';
import '../dashboard_widgets/dashboard_responsive.dart';

import '../../../models/weather.dart';

class WeatherStrategySection extends ConsumerWidget {
  const WeatherStrategySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(teamProvider).tileColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _weatherCard(context, color, ref)),
        SizedBox(width: AppSpacing.sm),
        Expanded(child: _strategyCard(context, color)),
      ],
    );
  }

  Widget _weatherCard(BuildContext context, Color color, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return weatherAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('no session'),
      data: (weather) {
        if (weather.isEmpty) {
          return const Text('Off session');
        }

        final latestWeather = weather.last;

        return dashboardCard(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dashboardSectionLabel('WEATHER', color),
              const Divider(color: AppColors.divider),
              const SizedBox(height: AppSpacing.md),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    _weatherIcon(latestWeather),
                    size: contextWidth(context, 0.11),
                    color: AppColors.white,
                  ),
                  const SizedBox(width: AppSpacing.lg),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${latestWeather.airTemperature?.round() ?? '--'}°C',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: responsiveFont(context, 24),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${latestWeather.rainfall?.round() ?? '--'}% rain',
                        style: TextStyle(
                          color: AppColors.white54,
                          fontSize: responsiveFont(context, 11),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _weatherIcon(Weather weather) {
    final rain = weather.rainfall ?? 0;

    if (rain >= 60) {
      return Icons.water_drop_rounded;
    }
    if (rain >= 30) {
      return Icons.cloudy_snowing;
    }
    return Icons.wb_sunny_rounded;
  }

  Widget _strategyCard(BuildContext context, Color color) {
    return dashboardCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashboardSectionLabel('STRATEGY', color),
          const Divider(color: AppColors.divider),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              dashboardTyreIcon(context),
              SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT TYRE',
                      style: TextStyle(
                        color: AppColors.white54,
                        fontSize: responsiveFont(context, 10),
                      ),
                    ),
                    Text(
                      'MEDIUM',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: responsiveFont(context, 14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'AGE: 17 LAPS',
                      style: TextStyle(
                        color: AppColors.white54,
                        fontSize: responsiveFont(context, 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'PIT WINDOW',
            style: TextStyle(
              color: AppColors.white54,
              fontSize: responsiveFont(context, 10),
            ),
          ),
          Text(
            'LAP 32 - 38',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: responsiveFont(context, 15),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'AI CONFIDENCE',
            style: TextStyle(
              color: AppColors.white54,
              fontSize: responsiveFont(context, 10),
            ),
          ),
          Text(
            '87%',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: responsiveFont(context, 22),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
