import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:f1/models/driver_career_stats.dart';
import 'package:f1/models/jolpica_driver.dart';
import 'package:f1/models/race_result.dart';
import 'package:f1/providers/jolpica_providers.dart';
import 'package:f1/providers/racinghub_providers.dart';
import 'package:f1/core/widgets/flag_widget.dart';

class OverviewTab extends ConsumerWidget {
  final String driverNumber; // OpenF1 permanent number or code
  final String driverCode;

  const OverviewTab({
    super.key,
    required this.driverNumber,
    required this.driverCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. JOLPICA API calls for snapshot, basic info, and debut
    final jolpicaDriverAsync = ref.watch(jolpicaDriverProvider(driverNumber));
    final seasonResultsAsync = ref.watch(
      driverSeasonResultsProvider(driverNumber),
    );
    final debutAsync = ref.watch(driverDebutProvider(driverNumber));

    // 2. RACINGHUB API call: First bridge OpenF1 identifier to RacingHub driver
    final rhDriverAsync = ref.watch(
      racingHubDriverProvider((number: driverNumber, code: driverCode)),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Current Season Snapshot (Jolpica)
          _buildSectionHeader('CURRENT SEASON SNAPSHOT'),
          const SizedBox(height: 8),
          _buildCurrentSeasonSnapshot(jolpicaDriverAsync, seasonResultsAsync),

          const SizedBox(height: 24),

          // 2. Basic Info Section (Jolpica)
          _buildSectionHeader('BASIC INFO'),
          const SizedBox(height: 8),
          _buildBasicInfoGrid(context, jolpicaDriverAsync, debutAsync),

          const SizedBox(height: 24),

          // 3. Career Highlights Section (RacingHub)
          _buildSectionHeader('CAREER HIGHLIGHTS'),
          const SizedBox(height: 8),

          // Resolve driver first, then pass the native ID to the child widget
          rhDriverAsync.when(
            data: (rhDriver) => _CareerStatsLoader(racingHubId: rhDriver.id),
            loading: () => _buildLoadingState(),
            error: (err, stack) => _buildErrorState('$err'),
          ),
        ],
      ),
    );
  }

  // --- JOLPICA: Season Snapshot ---
  Widget _buildCurrentSeasonSnapshot(
    AsyncValue<JolpicaDriver> jolpicaDriverAsync,
    AsyncValue<dynamic> seasonResultsAsync,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.redAccent.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: jolpicaDriverAsync.when(
        data: (driver) {
          int seasonWins = 0;
          int seasonPodiums = 0;

          if (seasonResultsAsync.hasValue) {
            final races = seasonResultsAsync.value ?? [];
            for (final race in races) {
              final pos = race.position is int
                  ? race.position as int
                  : int.tryParse(race.position?.toString() ?? '');
              if (pos != null) {
                if (pos == 1) seasonWins++;
                if (pos <= 3) seasonPodiums++;
              }
            }
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatMetric('RANK', 'P${driver.position}'),
              _buildStatMetric(
                'POINTS',
                '${driver.points.toStringAsFixed(0)} PTS',
              ),
              _buildStatMetric('WINS', '$seasonWins'),
              _buildStatMetric('PODIUMS', '$seasonPodiums'),
            ],
          );
        },
        loading: () => const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.redAccent,
            ),
          ),
        ),
        error: (_, _) => const Center(
          child: Text(
            'Snapshot unavailable',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      ),
    );
  }

  // --- JOLPICA: Basic Info Grid ---
  Widget _buildBasicInfoGrid(
    BuildContext context,
    AsyncValue<JolpicaDriver> jolpicaDriverAsync,
    AsyncValue<RaceResult?> debutAsync,
  ) {
    return jolpicaDriverAsync.when(
      data: (driver) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  title: 'DRIVER CODE',
                  content: Text(
                    driver.code.isNotEmpty ? driver.code : 'N/A',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoCard(
                  title: 'NATIONALITY',
                  content: Row(
                    children: [
                      //FlagWidget(query: driver.nationality, isDemonym: true),
                      //const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          driver.nationality,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Date of Birth & Age Card
              Expanded(
                child: _buildInfoCard(
                  title: 'DATE OF BIRTH & AGE',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.dateOfBirth.isNotEmpty
                            ? _formatDate(driver.dateOfBirth)
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (driver.dateOfBirth.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${_calculateAge(driver.dateOfBirth)} yrs',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // F1 Debut Card (Year & GP separated non-linearly)
              Expanded(
                child: _buildInfoCard(
                  title: 'F1 DEBUT',
                  content: debutAsync.when(
                    data: (debut) {
                      if (debut == null) {
                        return const Text(
                          'N/A',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            debut.season.isNotEmpty ? debut.season : 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            debut.raceName.isNotEmpty ? debut.raceName : 'N/A',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    error: (_, _) => const Text(
                      'N/A',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      loading: () => const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.redAccent,
          ),
        ),
      ),
      error: (_, _) => const Text(
        'Basic info unavailable',
        style: TextStyle(color: Colors.white54),
      ),
    );
  }

  // Reusable Shared UI States
  Widget _buildLoadingState() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.redAccent),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(message, style: const TextStyle(color: Colors.redAccent)),
      ),
    );
  }

  // Helper Methods
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildStatMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          content,
        ],
      ),
    );
  }

  int _calculateAge(String dobStr) {
    try {
      final dob = DateTime.parse(dobStr);
      final today = DateTime.now();
      int age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return 0;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final parsed = DateTime.parse(dateStr);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year}';
    } catch (_) {
      return dateStr;
    }
  }
}

// --- RACINGHUB: Extracted Sub-Widget ---
class _CareerStatsLoader extends ConsumerWidget {
  final String racingHubId;

  const _CareerStatsLoader({required this.racingHubId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch stats dynamically using the resolved native RacingHub ID
    final careerStatsAsync = ref.watch(driverCareerStatsProvider(racingHubId));

    return careerStatsAsync.when(
      data: (stats) => Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: [
              _buildHighlightCard('WORLD CHAMPIONSHIPS', '${stats.wdc}x WDC'),
              _buildHighlightCard('CAREER WINS', '${stats.wins}'),
              _buildHighlightCard('PODIUMS', '${stats.podiums}'),
              _buildHighlightCard('POLE POSITIONS', '${stats.poles}'),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildListRow(
                  'RACINGHUB ID',
                  racingHubId,
                ), // Visually pass/show ID in the UI here
                const Divider(color: Colors.white10),
                _buildListRow('FASTEST LAPS', '${stats.fastestLaps}'),
                const Divider(color: Colors.white10),
                _buildListRow('GRAND PRIX STARTS', '${stats.starts}'),
                const Divider(color: Colors.white10),
                _buildListRow(
                  'TOTAL CAREER POINTS',
                  '${stats.totalPoints.toStringAsFixed(1)} PTS',
                ),
                const Divider(color: Colors.white10),
                _buildListRow(
                  'F1 DEBUT',
                  '${stats.debutYear} ${stats.debutGp}',
                ),
                const Divider(color: Colors.white10),
                _buildListRow(
                  'BEST FINISH',
                  stats.wins > 0
                      ? 'P1 (${stats.wins}x)'
                      : 'P${stats.bestFinishPosition} (${stats.bestFinishGp ?? "N/A"})',
                ),
              ],
            ),
          ),
        ],
      ),
      loading: () => Container(
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.redAccent),
        ),
      ),
      error: (_, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Failed to load career statistics',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
