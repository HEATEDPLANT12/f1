class PitStop {
  final int driverNumber;
  final int lapNumber;
  final double? pitDuration;

  const PitStop({
    required this.driverNumber,
    required this.lapNumber,
    required this.pitDuration,
  });

  factory PitStop.fromJson(Map<String, dynamic> json) {
    return PitStop(
      driverNumber: json["driver_number"],
      lapNumber: json["lap_number"],
      pitDuration: double.tryParse(json["pit_duration"]?.toString() ?? ""),
    );
  }
}
