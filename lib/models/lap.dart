class Lap {
  final int driverNumber;
  final int lapNumber;
  final double? lapDuration;
  final double? sector1;
  final double? sector2;
  final double? sector3;
  final bool? isPitOutLap;

  const Lap({
    required this.driverNumber,
    required this.isPitOutLap,
    required this.lapDuration,
    required this.lapNumber,
    required this.sector1,
    required this.sector2,
    required this.sector3,
  });

  factory Lap.fromJson(Map<String, dynamic> json) {
    return Lap(
      driverNumber: json["driver_number"],
      lapNumber: json["lap_number"],
      lapDuration: double.tryParse(json["lap_duration"]?.toString() ?? ""),
      sector1: double.tryParse(json["duration_sector_1"]?.toString() ?? ""),
      sector2: double.tryParse(json["duration_sector_2"]?.toString() ?? ""),
      sector3: double.tryParse(json["duration_sector_3"]?.toString() ?? ""),
      isPitOutLap: json["is_pit_out_lap"],
    );
  }
}
