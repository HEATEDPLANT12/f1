class RaceResult {
  final String season;
  final int round;
  final String raceName;
  final String country;
  final String locality;
  final String position;
  final String grid;
  final String points;
  final String laps;
  final String status;
  final String? fastestLapTime;

  RaceResult({
    this.season = '',
    required this.round,
    required this.raceName,
    required this.country,
    required this.locality,
    required this.position,
    required this.grid,
    required this.points,
    required this.laps,
    required this.status,
    this.fastestLapTime,
  });

  factory RaceResult.fromJson(Map<String, dynamic> json) {
    final results = json['Results'] as List? ?? [{}];
    final result = results[0];
    final circuit = json['Circuit'] ?? {};
    final location = circuit['Location'] ?? {};

    final fastestLap = result['FastestLap'];
    final time = (fastestLap != null && fastestLap['Time'] != null)
        ? fastestLap['Time']['time']
        : null;

    return RaceResult(
      season: json['season']?.toString() ?? '',
      round: int.tryParse(json['round']?.toString() ?? '0') ?? 0,
      raceName: json['raceName'] ?? '',
      country: location['country'] ?? '',
      locality: location['locality'] ?? '',
      position: result['position']?.toString() ?? '-',
      grid: result['grid']?.toString() ?? '-',
      points: result['points']?.toString() ?? '0',
      laps: result['laps']?.toString() ?? '0',
      status: result['status'] ?? 'Unknown',
      fastestLapTime: time,
    );
  }
}
