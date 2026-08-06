class Stint {
  final int driverNumber;
  final String? compound;
  final int lapStart;
  final int lapEnd;
  final int tyreAgeAtStart;

  const Stint({
    required this.compound,
    required this.driverNumber,
    required this.lapEnd,
    required this.lapStart,
    required this.tyreAgeAtStart,
  });

  factory Stint.fromJson(Map<String, dynamic> json) {
    return Stint(
      driverNumber: json["driver_number"],
      compound: json["compound"],
      lapEnd: json["lap_end"],
      lapStart: json["lap_start"],
      tyreAgeAtStart: json["tyre_age_at_start"],
    );
  }
}
