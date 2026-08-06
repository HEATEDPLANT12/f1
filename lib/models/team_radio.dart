class TeamRadio {
  final int driverNumber;
  final String date;
  final String recordingUrl;

  const TeamRadio({
    required this.date,
    required this.driverNumber,
    required this.recordingUrl,
  });

  factory TeamRadio.fromJson(Map<String, dynamic> json) {
    return TeamRadio(
      driverNumber: json["driver_number"],
      date: json["date"],
      recordingUrl: json["recording_url"],
    );
  }
}
