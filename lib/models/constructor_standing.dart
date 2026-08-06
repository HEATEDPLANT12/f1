class ConstructorStanding {
  final int position;
  final int points;
  final int wins;

  final String constructorId;
  final String name;
  final String nationality;

  const ConstructorStanding({
    required this.position,
    required this.points,
    required this.wins,
    required this.constructorId,
    required this.name,
    required this.nationality,
  });

  factory ConstructorStanding.fromJson(Map<String, dynamic> json) {
    final constructor = json["Constructor"];

    return ConstructorStanding(
      position: int.parse(json["position"]),
      points: int.parse(json["points"]),
      wins: int.parse(json["wins"]),

      constructorId: constructor["constructorId"],
      name: constructor["name"],
      nationality: constructor["nationality"],
    );
  }
}
