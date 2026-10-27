class JolpicaDriver {
  final String driverId;
  final int permanentNumber;
  final String code;
  final String givenName;
  final String familyName;
  final String dateOfBirth;
  final String nationality;
  final String constructorId;
  final String constructorName;
  final int position;
  final double points;
  final int wins;

  String get fullName => '$givenName $familyName';

  const JolpicaDriver({
    required this.driverId,
    required this.permanentNumber,
    required this.code,
    required this.givenName,
    required this.familyName,
    required this.dateOfBirth,
    required this.nationality,
    required this.constructorId,
    required this.constructorName,
    required this.position,
    required this.points,
    required this.wins,
  });

  /*String get racinghubId {
    final given = givenName.trim().toLowerCase().replaceAll(' ', '-');
    final family = familyName.trim().toLowerCase().replaceAll(' ', '-');
    return '$given-$family';
  }*/

  factory JolpicaDriver.fromStandingJson(Map<String, dynamic> json) {
    final driverJson = json['Driver'] ?? {};
    final constructors = json['Constructors'] as List? ?? [];
    final constructorJson = constructors.isNotEmpty ? constructors[0] : {};

    return JolpicaDriver(
      driverId: driverJson['driverId'] ?? '',
      permanentNumber: int.tryParse(driverJson['permanentNumber'] ?? '0') ?? 0,
      code: driverJson['code'] ?? '',
      givenName: driverJson['givenName'] ?? '',
      familyName: driverJson['familyName'] ?? '',
      dateOfBirth: driverJson['dateOfBirth'] ?? '',
      nationality: driverJson['nationality'] ?? '',
      constructorId: constructorJson['constructorId'] ?? '',
      constructorName: constructorJson['name'] ?? '',
      position: int.tryParse(json['position']?.toString() ?? '0') ?? 0,
      points: double.tryParse(json['points']?.toString() ?? '0') ?? 0.0,
      wins: int.tryParse(json['wins']?.toString() ?? '0') ?? 0,
    );
  }
}
