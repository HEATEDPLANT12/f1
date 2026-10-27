class DriverCareerStats {
  final String id;
  final String countryId;
  final int wdc;
  final int wins;
  final int podiums;
  final int poles;
  final int fastestLaps;
  final int starts;
  final double totalPoints;
  final String debutGp;
  final String debutYear;
  final int bestFinishPosition;
  final String? bestFinishGp;

  DriverCareerStats({
    required this.id,
    required this.countryId,
    required this.wdc,
    required this.wins,
    required this.podiums,
    required this.poles,
    required this.fastestLaps,
    required this.starts,
    required this.totalPoints,
    required this.debutGp,
    required this.debutYear,
    required this.bestFinishPosition,
    this.bestFinishGp,
  });

  String get formattedCountry {
    if (countryId.isEmpty) return '';
    return countryId
        .split('-')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : '',
        )
        .join(' ');
  }

  factory DriverCareerStats.fromJson(Map<String, dynamic> json) {
    return DriverCareerStats(
      id: json['id'] ?? '',
      countryId: json['nationality_country_id'] ?? '',
      wdc: json['total_championship_wins'] ?? 0,
      wins: json['total_race_wins'] ?? 0,
      podiums: json['total_podiums'] ?? 0,
      poles: json['total_pole_positions'] ?? 0,
      fastestLaps: json['total_fastest_laps'] ?? 0,
      starts: json['total_race_starts'] ?? 0,
      totalPoints:
          double.tryParse(json['total_points']?.toString() ?? '0') ?? 0.0,
      debutGp: json['first_race_name'] ?? 'N/A',
      debutYear: json['first_race_season']?.toString() ?? 'N/A',
      bestFinishPosition: json['best_race_result'] ?? 0,
      bestFinishGp: json['best_race_result_gp'],
    );
  }
}
