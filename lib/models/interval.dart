class Interval {
  final int driverNumber;
  final double? gapToLeader;
  final double? interval;

  const Interval({
    required this.driverNumber,
    required this.gapToLeader,
    required this.interval,
  });

  factory Interval.fromJson(Map<String, dynamic> json) {
    return Interval(
      driverNumber: json["driver_number"],
      gapToLeader: double.tryParse(json["gap_to_leader"]?.toString() ?? ""),
      interval: double.tryParse(json["interval"]?.toString() ?? ""),
    );
  }
}
