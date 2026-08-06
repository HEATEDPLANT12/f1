class OpenF1Driver {
  final int driverNumber;
  final String fullName;
  final String broadcastName;
  final String teamName;
  final String teamColour;
  final String? countryCode;
  final String? headshotUrl;

  const OpenF1Driver({
    required this.driverNumber,
    required this.fullName,
    required this.broadcastName,
    required this.teamName,
    required this.teamColour,
    required this.countryCode,
    this.headshotUrl,
  });

  factory OpenF1Driver.fromJson(Map<String, dynamic> json) {
    return OpenF1Driver(
      driverNumber: json["driver_number"],
      fullName: json["full_name"],
      broadcastName: json["broadcast_name"],
      teamName: json["team_name"],
      teamColour: json["team_colour"],
      countryCode: json["country_code"],
      headshotUrl: json["headshot_url"],
    );
  }
}
