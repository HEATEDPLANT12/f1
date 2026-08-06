class Session {
  final int sessionKey;

  final String sessionName;
  final String sessionType;

  final String countryName;
  final String circuitShortName;

  final String dateStart;
  final String dateEnd;

  const Session({
    required this.sessionKey,
    required this.sessionName,
    required this.sessionType,
    required this.countryName,
    required this.circuitShortName,
    required this.dateStart,
    required this.dateEnd,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionKey: json["session_key"],
      sessionName: json["session_name"],
      sessionType: json["session_type"],
      countryName: json["country_name"],
      circuitShortName: json["circuit_short_name"],
      dateStart: json["date_start"],
      dateEnd: json["date_end"],
    );
  }
}
