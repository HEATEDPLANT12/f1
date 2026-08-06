class Position {
  final int position;
  final int drivernumber;
  final int sessionKey;
  final String date;

  const Position({
    required this.date,
    required this.drivernumber,
    required this.position,
    required this.sessionKey,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      position: json["position"],
      drivernumber: json["driver_number"],
      sessionKey: json["session_key"],
      date: json["date"],
    );
  }
}
