class Weather {
  final String date;
  final int sessionKey;

  final double? airTemperature;
  final double? trackTemperature;
  final double? humidity;
  final double? rainfall;
  final double? windSpeed;
  final int? windDirection;

  const Weather({
    required this.airTemperature,
    required this.humidity,
    required this.rainfall,
    required this.trackTemperature,
    required this.windSpeed,
    required this.date,
    required this.sessionKey,
    required this.windDirection,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json["date"],
      sessionKey: json["session_key"],
      airTemperature: double.tryParse(
        json["air_temperature"]?.toString() ?? "",
      ),
      trackTemperature: double.tryParse(
        json["track_temperature"]?.toString() ?? "",
      ),
      humidity: double.tryParse(json["humidity"]?.toString() ?? ""),
      rainfall: double.tryParse(json["rainfall"]?.toString() ?? ""),
      windSpeed: double.tryParse(json["wind_speed"]?.toString() ?? ""),
      windDirection: json["wind_direction"],
    );
  }
}
