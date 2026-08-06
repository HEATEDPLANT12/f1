class CarData {
  final int driverNumber;
  final int speed;
  final int rpm;
  final int gear;
  final int throttle;
  final int brake;
  final bool drs;
  final String date;

  const CarData({
    required this.brake,
    required this.date,
    required this.driverNumber,
    required this.drs,
    required this.gear,
    required this.rpm,
    required this.speed,
    required this.throttle,
  });

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
      driverNumber: json["driver_number"],
      speed: json["speed"],
      rpm: json["rpm"],
      gear: json["n_gear"],
      throttle: json["throttle"],
      brake: json["brake"],
      drs: json["drs"] == 1,
      date: json["date"],
    );
  }
}
