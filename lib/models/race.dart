class Race {
  final String raceName;
  final String circuitName;
  final String locality;
  final String country;
  final String date;
  final String time;

  const Race({
    required this.raceName,
    required this.circuitName,
    required this.locality,
    required this.country,
    required this.date,
    required this.time,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    final circuit = json["Circuit"];
    final location = circuit["Location"];

    return Race(
      raceName: json["raceName"],
      date: json["date"],
      time: json["time"] ?? "",
      circuitName: circuit["circuitName"],
      locality: location["locality"],
      country: location["country"],
    );
  }
}
