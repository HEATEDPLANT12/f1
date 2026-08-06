class DriverStanding {
  final String code;
  final String firstName;
  final String lastName;
  final String permanentNumber;
  final String nationality;
  final String team;
  final int position;
  final int points;
  final int wins;

  const DriverStanding({
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.permanentNumber,
    required this.nationality,
    required this.team,
    required this.position,
    required this.points,
    required this.wins,
  });

  factory DriverStanding.fromJson(Map<String, dynamic> json) {
    return DriverStanding(
      code: json["Driver"]["code"] ?? "",
      firstName: json["Driver"]["givenName"],
      lastName: json["Driver"]["familyName"],
      permanentNumber: json["Driver"]["permanentNumber"] ?? "",
      nationality: json["Driver"]["nationality"],
      team: json["Constructors"][0]["name"],
      position: int.parse(json["position"]),
      points: int.parse(json["points"]),
      wins: int.parse(json["wins"]),
    );
  }
}
